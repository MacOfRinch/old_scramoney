class PushLineMessageJob < ApplicationJob
  require 'line/bot'
  include Rails.application.routes.url_helpers
  queue_as :default

  def perform(*args)
    # Do something later
    users = User.all
    users.each do |user|
      if user.line_flag == true
        new_record_url = 'https://' + Settings.default_url_options.host + new_family_record_path(user.family)
        message = {
        type: 'text',
        text: "あなたの現在のお小遣いは#{user.calculate_pocket_money}円です！記録漏れはありませんか？#{new_record_url}"
        }
        response = line_client.push_message(user.line_user_id, message)
        user.line_flag = false
      end
    end
  end

  private

  def line_client
    @line_client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  protected

  def default_url_options
    { host: ENV['HEROKU_APP_NAME'] }
  end
end
