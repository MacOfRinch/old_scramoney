class PasswordResetsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :set_family

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    @user.deliver_reset_password_instructions! if @user
    redirect_to(login_path, notice: 'パスワードリセット方法を送信しました。')
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    if @user.blank?
      not_authenticated
    end
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to(root_path, notice: 'パスワードが正常に更新されました')
    else
      flash.now[:danger] = 'パスワードリセットに失敗しました'
      render :edit
    end
  end
end
