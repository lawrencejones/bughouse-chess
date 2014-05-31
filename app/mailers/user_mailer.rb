class UserMailer < ActionMailer::Base
  default from: "support@bughouse-chess.com"
  
  def send_signup_email(user)
    @user = user
    mail( to: @user.email, subject: "Thanks for signing up")
  end
  
  def send_password_reset_email(user)
    @user = user
    mail( to: @user.email, subject: "Password reset from Bughouse Chess")  
  end
  
end
