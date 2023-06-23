class FamiliesController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :set_family, only: %i[new create]
  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)

    if @family.save
      redirect_to new_family_user_path(@family), success: '家族を登録しました'
    else
      falsh.now[:danger] = '家族の登録に失敗しました'
      render :new
    end
  end

  def show

  end

  private

  def family_params
    params.require(:family).permit(:name, :nickname, :budget)
  end
end
