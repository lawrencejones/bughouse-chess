class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      
      if params[:remember_me] == nil    
        flash[:danger] = "fail"
      else
        flash[:success] = "success"
      end

	    if params[:remember_me]
		  		sign_in user
			else  
      		one_time_sign user
      	end
      	redirect_back_or user
    else
	    flash.now[:danger] = 'Invalid email/password combination.'
      render 'new'    
    end
  end

  def destroy
  	sign_out
  	redirect_to root_url
  end
end
