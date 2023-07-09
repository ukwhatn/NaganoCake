class Admin::HomesController < ApplicationController
  # 管理者としてログインしていないとアクセスできないようにする
  before_action :authenticate_admin!

  def top
    # kaminariを利用してページネーションを行う
    # reverse_orderをつけると、逆順（新しい順）に並べることができる
    @orders = Order.page(params[:page]).per(10).reverse_order
  end
end
