class HomeController < ApplicationController
  skip_before_action :require_login
  skip_before_action :set_family

  def top
    if logged_in?
      family = current_user.family
      redirect_to family_path(family)
    else
      redirect_to login_path
    end
  end
end
