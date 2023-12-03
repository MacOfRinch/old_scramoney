# frozen_string_literal: true

namespace :notices do
  desc '先月のポイント、お小遣いを算出して通知するよ。'
  task generate: :environment do
    families = Family.all
    families.each do |family|
      users = family.users
      users.each do |user|
        @notice = Notice.create!(title: '今月のお小遣いのお知らせ', family_id: family.id, user_id: user.id,
                                 notice_type: :pocket_money)
        Read.create!(user_id: user.id, notice_id: @notice.id, checked: false)
        user.line_flag = true if user.line_user_id
      end
    end
  end

  desc '今週のお小遣いをお知らせするよ。'
  task report_money_of_this_week: :environment do
    WeeklyNoticeJob.perform_now
  end
end
