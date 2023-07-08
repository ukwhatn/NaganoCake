class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :check_ownership, only: [:update, :destroy]

  def index
    @cart_items = current_customer.cart_items
  end

  def create
    exist_cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id], customer_id: current_customer.id)
    if exist_cart_item
      exist_cart_item.amount += params[:cart_item][:amount].to_i
      if exist_cart_item.amount > 10
        exist_cart_item.amount = 10
      end
      exist_cart_item.save
    else
      cart_item = CartItem.new(cart_item_params)
      cart_item.customer_id = current_customer.id
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

  def check_ownership
    @cart_item = CartItem.find(params[:id])
    unless current_customer.id == @cart_item.customer.id
      redirect_to cart_items_path
    end
  end
end
