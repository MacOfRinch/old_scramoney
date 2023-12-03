# frozen_string_literal: true

class NoticesController < ApplicationController
  def create
    @notice = Notice.new
  end

  def index
    @notices = Notice.where(family_id: @family.id, user_id: current_user.id)
  end

  # 各ユーザーがページを開いたらReadモデルのcheckedをtrueにして既読にするよ。それまでは未読(flase)だよ。
  def show
    @notice = Notice.find(params[:id])
    @users = @family.users
    read = Read.find_by(user_id: current_user.id, notice_id: @notice.id, checked: false)
    if read
      read.update(checked: true)
    end
    # このままでは月が過ぎると自動的に先月になってしまうから直さねばならぬ
    @each_name_points = each_name_points_of_last_month(@users)
    @each_pocket_money = each_pocket_money_of_last_month(@users)
    return unless @notice.notice_type == 'approval_request'

    @request = ApprovalRequest.find(@notice.approval_request_id)
    @new_family_data = TemporaryFamilyDatum.find_by(approval_request_id: @notice.approval_request_id)
  end

  def show_approval_request
    @notice = Notice.find(params[:notice_id])
    @users = @family.users
    read = Read.find_by(user_id: current_user.id, notice_id: @notice.id, checked: false)
    if read
      read.update(checked: true)
    end

    return unless @notice.notice_type == 'approval_request'

    @request = ApprovalRequest.find(@notice.approval_request_id)
    @new_family_data = TemporaryFamilyDatum.find_by(approval_request_id: @notice.approval_request_id)
  end

  def destroy
    notice = Notice.find(params[:id])
    notice.destroy!
  end

  private

  def each_name_points_of_last_month(users)
    result = []
    users.sort_by{ |user| user.sum_points_of_last_month }.reverse.each do |user|
      array = ["#{display_name(user)}: #{user.sum_points_of_last_month}pt (#{user.percent_of_last_month}%)",
               user.sum_points_of_last_month]
      result << array
    end
    result
  end

  def each_pocket_money_of_last_month(users)
    result = []
    users.sort_by{ |user| user.calculate_pocket_money_of_last_month }.reverse.each do |user|
      array = ["#{display_name(user)}: #{user.calculate_pocket_money_of_last_month.to_s(:delimited)}円",
               user.calculate_pocket_money_of_last_month]
      result << array
    end
    result
  end
end
