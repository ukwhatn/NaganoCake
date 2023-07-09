# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # create(ログイン)処理の実行前に、reject_inactive_customerメソッドを実行する
  before_action :reject_inactive_customer, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # 顧客ログイン・ログアウト後のリダイレクト先は、application_controller.rbではなくここで設定する
  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # 退会済みの顧客がログインできないようにする
  def reject_inactive_customer
    # emailカラムに入力された値をもとに、Customerテーブルからレコードを取得する
    @customer = Customer.find_by(email: params[:customer][:email])

    # レコードが取得できた場合(ユーザが存在する場合)に以下の処理を実行
    if @customer
      # パスワードが正しい場合、かつ、is_deletedカラムの値がtrue(退会済み)の場合に以下の処理を実行
      if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted
        # ログイン画面にエラーメッセージを表示させる
        flash[:alert] = 'お客様は退会済みです。申し訳ございませんが、別のメールアドレスをお使いください。'
        # ログイン画面にリダイレクトさせる
        redirect_to new_customer_session_path
      end
    end
  end
end
