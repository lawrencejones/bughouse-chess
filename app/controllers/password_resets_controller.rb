class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:email].downcase)
    if !user.nil?
      user.send_reset_email 
      redirect_to root_url
      flash[:success] = "Email with instructions has been sent"
    else     
      redirect_to new_password_reset_path
      flash[:error] = "Invalid e-mail!"
    end
  end
    
  def edit
    @user = User.find_by_password_reset_token!(params[:id]) 
  end
  
  def update
    @user = User.find_by(password_reset_token: params[:id])
    if Time.zone.now - (2/24.0) < @user.password_reset_sent_at
      redirect_to new_password_reset_path
      flash[:error] = "Password reset has expired!"
    elsif @user.update_attribute(:password, params[:user])
      redirect_to @user
      flash[:success] = "Password reset has been successful!"
    else
      render 'edit'
    end
  end
  
end
