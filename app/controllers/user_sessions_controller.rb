class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :set_family, only: %i[new create]

  def new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to family_path(@user.family), notice: 'ログイン成功'
    else
      flash.now[:alert] = "ログイン失敗"
      render :new
    end
  end

  def destroy
    logout
    redirect_to login_path, status: :see_other # see_otherがないと大変なことになる
  end
end
