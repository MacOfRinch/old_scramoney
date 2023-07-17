class FamilyProfilesController < ApplicationController
  def show
  end

  def edit
  end

  def update
    if @family.update(family_params)
      redirect_to family_profile_path
    else
      render :edit
    end
  end

  private

  def family_params
    params.require(:family).permit(:name, :nickname, :avatar, :avatar_cache, :budget)
  end
end
