class HomeController < ApplicationController
  def top
    if logged_in?
      redirect_to family_path(@family)
    else
      redirect_to login_path
    end
  end
end
