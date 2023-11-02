# frozen_string_literal: true

class FamiliesController < ApplicationController
  skip_before_action :require_login, only: :invitation
  skip_before_action :set_family, only: :invitation

  def show
    users = @family.users
    @each_name_points = each_name_points(users)
    @each_pocket_money = each_pocket_money(users)
  end

  def configuration; end

  def invitation
    if logged_in?
      @family = current_user.family
      @invitation_code = current_user.family_id
    else
      # URLに書かれてるfamily_idを招待コードとして取得しておくよ。
      @invitation_code = params[:family_id]
    end
  end

  private

  def each_name_points(users)
    result = []
    users.each do |user|
      array = ["#{display_name(user)}:#{user.sum_points}pt (#{user.percent}%)", user.sum_points]
      result << array
    end
    result
  end

  def each_pocket_money(users)
    result = []
    users.each do |user|
      array = ["#{display_name(user)}:#{user.calculate_pocket_money.to_s(:delimited)}円", user.calculate_pocket_money]
      result << array
    end
    result
  end
end
