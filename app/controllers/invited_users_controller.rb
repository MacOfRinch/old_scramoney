class InvitedUsersController < ApplicationController
  skip_before_action :set_family
  skip_before_action :require_login

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.pocket_money = 0
    if @user.save
      family = Family.find(params[:family_id])
      redirect_to family_path(family)
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :family_id)
  end
end
