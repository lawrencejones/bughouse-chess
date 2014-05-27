class UserMailer < ActionMailer::Base
  default from: "bughouse-chess-people@coolestguys.com"
  
  def send_welcome_email(user)
    @user = user
    mail( to: @user.mail, subject: "Thanks for signing up with Bughouse Chess Online")
  end
end
