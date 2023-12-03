class ApprovedEditFamilyProfileJob < PushLineMessageJob
  queue_as :default

  def perform(user)
    # Do something later
    if user.line_user_id && user.line_flag
      message = {
        type: 'text',
        text: "あなたの申請が承認され、家族プロフィールが更新されました！\n名字：#{user.family.family_name}\nニックネーム：#{user.family.family_nickname}\nお小遣い予算：#{user.family.budget.to_s(:delimited)}円"
                }
      line_client.push_message(user.line_user_id, message)
    end
  end
end
