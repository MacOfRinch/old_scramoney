class UserMailer < ApplicationMailer

  def invitation(user)
    @user = user
    mail to: @user.email, subject: "Scramoneyに招待されたゾッ"
  end
end
