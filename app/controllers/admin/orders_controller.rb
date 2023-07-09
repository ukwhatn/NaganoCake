class Admin::OrdersController < ApplicationController
  # 管理者としてログインしていないとアクセスできないようにする
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end
end
