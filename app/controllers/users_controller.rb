class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :set_family, only: %i[new create]
  before_action :set_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.pocket_money = 0
    @user.family_id = params[:family_id]

    if @user.save
      auto_login(@user)
      redirect_to family_path(@user.family), success: 'Scramoneyへようこそ!'
    else
      flash.now[:danger] = '入力内容に誤りがあります'
      render :new
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :avatar, :avatar_cache, :password, :password_confirmation)
  end
end
