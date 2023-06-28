class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :set_family, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.avatar ||= ''
    @user.family_id = params[:family_id]

    if @user.save
      redirect_to family_path(current_user.family)
    else
      render :new
    end
  end
  def edit

  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to family_user_path(current_user)
    else
      render :edit
    end

  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :avatar)
  end
end
