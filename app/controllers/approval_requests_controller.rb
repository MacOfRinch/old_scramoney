class ApprovalRequestsController < ApplicationController
  before_action :set_request

  def approve
    status = ApprovalStatus.find_by(approval_request_id: @request.id, user_id: current_user.id)
    status.update!(status: :accept)
    @family.apply_changes_if_approved(@request)
    redirect_to family_path(@family), success: '変更を承認しました'
  end

  def refuse
    status = ApprovalStatus.find_by(approval_request_id: @request.id, user_id: current_user.id)
    status.update!(status: :refuse)
    @family.apply_changes_if_approved(@request)
    redirect_to family_path(@family), alert: '変更を拒否しました'
  end

  private

  def set_request
    @request = ApprovalRequest.find(params[:id])
  end
end
