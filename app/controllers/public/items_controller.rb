class Public::ItemsController < ApplicationController
  # このコントローラーはログインしていなくてもアクセスできるようにする
  def index
    # kaminariを利用してページネーションを行う
    @items = Item.page(params[:page]).per(8)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
