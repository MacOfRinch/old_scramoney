# frozen_string_literal: true

namespace :past_data do
  desc '2ヶ月以上過去のタスクと通知を削除'
  task delete: :environment do
    old_records = TaskUser.where('created_at <= ?', 2.months.ago)
    old_records.each(&:destroy!)

    old_temporary_data = TemporaryFamilyDatum.where('created_at <= ?', 2.months.ago)
    old_temporary_data.each(&:destroy!)

    old_request_data = ApprovalRequest.where('created_at <= ?', 2.months.ago)
    old_request_data.each(&:destroy!)

    old_status_data = ApprovalStatus.where('created_at <= ?', 2.months.ago)
    old_status_data.each(&:destroy!)

    old_notices = Notice.where('created_at <= ?', 2.months.ago)
    old_notices.each(&:destroy!)
  end
end
