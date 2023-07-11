class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)

    @order = @order_detail.order

    if @order_detail.making_status == "in_production"
      @order_detail.order.update(status: "in_production")
    end

    if @order.order_details.count == @order.order_details.where(making_status: "complete").count
      @order.update(status: "preparing_for_shipping")
    end

    redirect_to admin_order_path(@order_detail.order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
