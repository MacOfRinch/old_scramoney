# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :set_family, only: %i[new create]
  require 'securerandom'

  def new
    logout
    reset_session
    @link_token = params[:linkToken]
  end

  def create
    @link_token = params[:linkToken]
    @user = login(params[:email], params[:password], params[:remember_me], params[:linkToken])
    # linkTokenがあった場合、後付けでのアカウント連携を行うよ。有効期限10分のnonceを発行して認証に使うよ。
    if @user && @link_token
      new_nonce = Nonce.create!(user_id: @user.id, nonce: @user.id.to_s + SecureRandom.hex(16), expires_at: Time.now + 10.minutes)
      nonce = new_nonce.nonce
      redirect_to "https://access.line.me/dialog/bot/accountLink?linkToken=#{@link_token}&nonce=#{nonce}", allow_other_host: true
    elsif @user
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
