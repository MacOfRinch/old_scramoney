class OauthsController < ApplicationController
  require 'securerandom'
  skip_before_action :require_login, raise: false
  skip_before_action :set_family

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if (@user = login_from(provider))
      redirect_to family_path(@user.family), success: "#{provider.titleize}でログインしました"
    else
      @user = create_from(provider)
      # 仮でランダムなアドレスとパスワードをセットしとくよ
      @user.email ||= fake_email
      @user.password ||= SecureRandom.urlsafe_base64
      @user.provider ||= provider
      if @user.family.nil?
        @family = Family.create(family_name: '名無し', budget: 50_000)
        @user.family = @family
        @user.save!
        reset_session
        auto_login(@user)
        redirect_to edit_family_path(@family), success: "#{provider.titleize}で認証しました。次に家族情報を入力してください。"
      else
        reset_session
        auto_login(@user)
        redirect_to family_path(@user.family), success: "#{provider.titleize}で#{@family.family_name}家に招待されました"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :error, :state)
  end

  def fake_email
    fake_email = "#{SecureRandom.urlsafe_base64}@example.com"
    while User.find_by(email: fake_email).present?
      fake_email = "#{SecureRandom.urlsafe_base64}@example.com"
    end
    fake_email
  end
end
