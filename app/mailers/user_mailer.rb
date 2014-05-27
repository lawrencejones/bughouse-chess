class UserMailer < ActionMailer::Base
  default from: "bughouse-chess-people@example.com"
  
  def send_signup_email(user)
    @user = user
    mail( to: @user.email, subject: "Thanks for signing up with Bughouse Chess Online")
  end
end
