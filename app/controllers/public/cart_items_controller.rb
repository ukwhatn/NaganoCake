class Public::CartItemsController < ApplicationController
  # 顧客としてログインしていないとアクセスできないようにする
  before_action :authenticate_customer!
  # update/destroyアクションの前に、check_ownershipメソッドを実行し、自分以外のカート商品を操作できないようにする
  before_action :check_ownership, only: [:update, :destroy]

  def index
    # current_customerを利用して、自分のカート商品を取得する
    @cart_items = current_customer.cart_items
  end

  def create
    # 同じ商品が同じ顧客のカートに存在しているかを確認
    # 存在した場合はレコードのリストが、存在しない場合はnilが返る
    exist_cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id], customer_id: current_customer.id)

    # nilの(既存のカート商品がない)場合はif文でfalseとなるので、else以下の処理が実行される
    if exist_cart_item
      # 既存のカート商品の数量に、新規追加する数量を足す
      exist_cart_item.amount += params[:cart_item][:amount].to_i
      # view上の制約により、10を超えた場合は10にする
      if exist_cart_item.amount > 10
        exist_cart_item.amount = 10
      end
      exist_cart_item.save
    else
      # カート内に同じ商品がなかった場合は、新規にカート商品を作成する
      cart_item = CartItem.new(cart_item_params)
      cart_item.customer_id = current_customer.id
      # view上の制約により、10を超えている場合は10にする
      if cart_item.amount > 10
        cart_item.amount = 10
      end
      cart_item.save
    end

    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id)
  end

  # 自分以外のカート商品へのアクセスがあった場合は、カート商品一覧ページにリダイレクトする
  def check_ownership
    @cart_item = CartItem.find(params[:id])
    unless current_customer.id == @cart_item.customer.id
      redirect_to cart_items_path
    end
  end
end
