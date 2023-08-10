namespace :past_data do
  desc '2ヶ月以上過去のタスクと半年以上前の通知を削除'
  task delete: :environment do
    old_records = TaskUser.where('created_at <= ?', 2.months.ago)
    old_records.each do |record|
      record.destroy!
    end

    old_temporary_data = TemporaryFamilyDatum.where('created_at <= ?', 2.months.ago)
    old_temporary_data.each do |data|
      data.destroy!
    end

    old_request_data = ApprovalRequest.where('created_at <= ?', 2.months.ago)
    old_request_data.each do |data|
      data.destroy!
    end

    old_status_data = ApprovalStatus.where('created_at <= ?', 2.months.ago)
    old_status_data.each do |data|
      data.destroy!
    end

    old_notices = Notice.where('created_at <= ?', 6.months.ago)
    old_notices.each do |notice|
      notice.destroy!
    end
  end
end
