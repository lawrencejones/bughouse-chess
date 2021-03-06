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
      flash[:danger] = "Invalid e-mail!"
    end
  end
    
  def edit
    @user = User.find_by_password_reset_token!(params[:id]) 
  end
  
  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user.password_reset_sent_at < 15.minutes.ago
      redirect_to new_password_reset_path
      flash[:danger] = "Password reset has expired!"
    elsif @user.update_attributes(updated_user_params)
      redirect_to root_url
      flash[:success] = "Password reset has been successful!"
    else
      render 'edit'
    end
  end
  
  private
    
    def updated_user_params
      params.require(:user).permit(:password,
      :password_confirmation)
    end
  
end
