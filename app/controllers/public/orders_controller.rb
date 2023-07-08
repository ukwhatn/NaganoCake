class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :confirm_reload_handler, only: [:show]
  before_action :check_ownership, only: [:show]

  def thanks
  end

  def new
    @order = Order.new
    @customer = current_customer
  end

  def confirm
    @order = current_customer.orders.new(order_params)
    @cart_items = current_customer.cart_items
    @order.shipping_cost = 800

    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.full_name

    @merchandise_total = @cart_items.sum(&:subtotal)
    @order.total_payment = @merchandise_total + @order.shipping_cost
  end

  def create
    @order = current_customer.orders.new(order_params)
    @cart_items = current_customer.cart_items
    @order.shipping_cost = 800
    @order.total_payment = @order.shipping_cost + @cart_items.sum(&:subtotal)
    if @order.save
      @cart_items.each do |cart_item|
        @order_detail = @order.order_details.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.price = cart_item.item.with_tax_price
        @order_detail.amount = cart_item.amount
        @order_detail.save
      end
      @cart_items.destroy_all
      redirect_to thanks_orders_path
    else
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

  def confirm_reload_handler
    if params[:id] == "confirm"
      redirect_to new_order_path
      return
    end
  end

  def check_ownership
    @order = Order.find(params[:id])
    if current_customer.id != @order.customer_id
      redirect_to orders_path
    end
  end
end
