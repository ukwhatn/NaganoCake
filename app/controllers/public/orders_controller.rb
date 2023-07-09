class Public::OrdersController < ApplicationController
  # 顧客としてログインしていないとアクセスできないようにする
  before_action :authenticate_customer!
  # confirm画面で再読み込みを行うとshowアクションに遷移してエラーとなってしまうのを防ぐ
  before_action :confirm_reload_handler, only: [:show]
  # 顧客が自分の注文履歴以外の注文履歴を見れないようにする
  before_action :check_ownership, only: [:show]

  def thanks
  end

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    # newで入力された値を受け取る
    @order = current_customer.orders.new(order_params)

    # 送料を800円に設定
    @order.shipping_cost = 800

    # ログイン中のCustomerから郵便番号・住所・氏名を取得
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.full_name

    # カート内の商品を取得
    @cart_items = current_customer.cart_items

    # 商品合計を計算
    # sumメソッドは配列の要素を全て足し合わせるメソッド
    # sum(&:subtotal)は、配列の要素それぞれに対してsubtotalメソッドを呼び出し、その結果を全て足し合わせる書き方
    @merchandise_total = @cart_items.sum(&:subtotal)
    # 請求額を計算
    @order.total_payment = @merchandise_total + @order.shipping_cost
  end

  def create
    # confirmのhidden_fieldから送られてきた値を受け取る
    @order = current_customer.orders.new(order_params)

    # カート内の商品を取得
    @cart_items = current_customer.cart_items

    # 送料を800円に設定
    @order.shipping_cost = 800

    # confirmと同様の方法で請求額を計算
    @order.total_payment = @order.shipping_cost + @cart_items.sum(&:subtotal)

    if @order.save
      # orderの保存に成功したら、order_detailsにカート内の商品を保存
      @cart_items.each do |cart_item|
        @order_detail = @order.order_details.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.price = cart_item.item.with_tax_price  # 税込価格で保存する
        @order_detail.amount = cart_item.amount
        @order_detail.save
      end

      # カート内の商品を削除 (destroy_allは複数のレコードをまとめて削除するメソッド)
      @cart_items.destroy_all

      # thanks画面に遷移
      redirect_to thanks_orders_path
    else
      # orderの保存に失敗したら、new画面に戻る
      render :new
    end
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method)
  end

  # confirm画面で再読み込みを行うとshowアクションに遷移してエラーとなってしまうのを防ぐ
  # confirmアクションのidパラメータが"confirm"の場合はnewアクションにリダイレクトする
  def confirm_reload_handler
    if params[:id] == "confirm"
      redirect_to new_order_path
      return
    end
  end

  # 顧客が自分の注文履歴以外の注文履歴を見れないようにする
  def check_ownership
    @order = Order.find(params[:id])
    if current_customer.id != @order.customer_id
      redirect_to orders_path
    end
  end
end
