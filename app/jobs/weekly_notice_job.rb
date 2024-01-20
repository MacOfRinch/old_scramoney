class WeeklyNoticeJob < PushLineMessageJob
  queue_as :default

  def perform(*args)
    # Do something later
    # includes使ってN+1問題回避できない？
    users = User.all
    users.each do |user|
      if user.line_user_id && user.line_flag
        record_url = 'https://' + Settings.default_url_options.host + family_records_path(user.family)
        message = {
        type: 'text',
        text: "あなたの現在のお小遣い振り分けは#{user.calculate_pocket_money.to_s(:delimited)}円です！\n記録漏れはありませんか？\n#{record_url}"
        }
        response = line_client.push_message(user.line_user_id, message)
      end
    end
  end
end
