namespace :past_data do
  desc '2ヶ月以上過去のタスクを削除'
  task delete: :environment do
    old_records = TaskUser.where('created_at <= ?', 2.months.ago)
    old_records.each do |record|
      record.destroy!
    end
  end
end
