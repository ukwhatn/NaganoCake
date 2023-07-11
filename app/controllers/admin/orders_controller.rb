class Admin::OrdersController < ApplicationController
  # 管理者としてログインしていないとアクセスできないようにする
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      if @order.status == "payment_confirmation"
        @order.order_details.each do |order_detail|
          order_detail.update(making_status: "in_production")
        end
      end
      redirect_to admin_order_path(@order)
    else
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
