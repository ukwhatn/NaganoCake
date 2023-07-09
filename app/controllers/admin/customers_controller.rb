class Admin::CustomersController < ApplicationController
  # 管理者としてログインしていないとアクセスできないようにする
  before_action :authenticate_admin!

  def index
    # kaminariを利用してページネーションを行う
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer)
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(
      :last_name, :first_name, :first_name_kana, :last_name_kana,
      :postal_code, :address, :telephone_number, :is_deleted, :email
    )
  end

end
