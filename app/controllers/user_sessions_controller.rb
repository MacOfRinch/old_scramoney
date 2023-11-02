# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :set_family, only: %i[new create]

  def new; end

  def create
    @user = login(params[:email], params[:password], params[:remember])

    if @user
      redirect_to family_path(@user.family), success: 'ログインに成功しました！'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to login_path, status: :see_other # see_otherがないと大変なことになる
  end
end
