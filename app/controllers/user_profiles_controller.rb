class UserProfilesController < ApplicationController
  skip_before_action :set_family
  before_action :set_user

  def show
  end

  def edit
  end

  def update
    if @user.update(user_praams)
      redirect_to user_profile_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :avatar, :avatar_cache)
  end
end
