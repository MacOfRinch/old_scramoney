# frozen_string_literal: true

class GoogleLoginApiController < ApplicationController
  # require 'googleauth/id_tokens/verifier'

  protect_from_forgery except: :callback
  before_action :verify_g_csrf_token

  def callback
    payload = Google::Auth::IDTokens.verify_oidc(params[:credential],
                                                 aud: '855052441133-h931vubm9ef4a5lshso99mi5275862d9.apps.googleusercontent.com')
    user = User.find_or_create_by(email: payload['email'])
    auto_login(user)
    redirect_to family_path(@family), success: 'ログインに成功しました！'
  end

  private

  def verify_g_csrf_token
    if cookies['g_csrf_token'].blank? || params[:g_csrf_token].blank? || cookies['g_csrf_token'] != params[:g_csrf_token]
      redirect_to login_path, danger: '不正なアクセスです'
    end
  end
end
