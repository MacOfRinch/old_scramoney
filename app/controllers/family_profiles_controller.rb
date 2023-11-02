# frozen_string_literal: true

class FamilyProfilesController < ApplicationController
  def show; end

  def edit; end

  def update
    @family.assign_attributes(family_params)
    if @family.valid?
      approval_request = ApprovalRequest.create(family_id: @family.id, user_id: current_user.id)
      TemporaryFamilyDatum.create(approval_request_id: approval_request.id, name: @family.family_name,
                                  nickname: @family.family_nickname, avatar: @family.family_avatar, budget: @family.budget)
      send_approval_request(approval_request)
      redirect_to family_path(@family), success: 'プロフィール編集の承認依頼を送りました'

    else
      flash.now[:danger] = '入力内容に誤りがあります'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def family_params
    params.require(:family).permit(:family_name, :family_nickname, :family_avatar, :family_avatar_cache, :budget)
  end

  def send_approval_request(approval_request)
    users = @family.users
    users.each do |user|
      if user == current_user
        # 申請した本人は承認したということにするよ。
        ApprovalStatus.create(approval_request_id: approval_request.id, user_id: user.id, status: :accept)
      else
        ApprovalStatus.create(approval_request_id: approval_request.id, user_id: user.id)
        notice = Notice.create(title: '家族プロフィール変更の承認依頼', family_id: @family.id, user_id: user.id,
                               notice_type: :approval_request, approval_request_id: approval_request.id)
        Read.create!(notice_id: notice.id, user_id: user.id, checked: false)
      end
    end
    @family.apply_changes_if_approved(approval_request)
  end
end
