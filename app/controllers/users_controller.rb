# frozen_string_literal: true

class UsersController < ApplicationController

  def destroy
    user = User.find(params[:id])
    user.destroy!
    redirect_to family_path(@family)
  end
end
