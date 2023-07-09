class Admin::ItemsController < ApplicationController
  # 管理者としてログインしていないとアクセスできないようにする
  before_action :authenticate_admin!
  def index
    # kaminariを利用してページネーションを行う
    @items = Item.all.page(params[:page]).per(10)
  end

  def new
    @new_item = Item.new
  end

  def create
    @new_item = Item.new(item_params)
    if @new_item.save
      redirect_to admin_item_path(@new_item)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :image)
  end
end
