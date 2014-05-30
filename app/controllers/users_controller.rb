class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :top10]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  helper_method :remove_image
 

  def index
    if params[:search]
      inter_rezult = Array.new
      q = params[:search].downcase
      @users = User.all
      # Hardcoded filter was necessary because normal does not work with heroku
      # for some reason heroku forces case sensitivity
      @users.each do |user|
        if user.name.downcase.include? q
          inter_rezult << user
        end
      end
      @users = inter_rezult.paginate(page: params[:page], per_page: 10)
    else
      @users = User.paginate(page: params[:page], per_page: 10)
    end
  end

  def top10
    @users = User.order('points DESC')[1..10]
  end

  def remove_image
    @user = User.find(params[:id])
    if @user.update_attribute(:avatar, nil)
      flash[:success] = "Profile picture has been successfully set to default." 
      redirect_to edit_user_path(@user) 
    else 
      render 'edit'
    end
  end

  def show
  	@user = User.find(params[:id])
  end

  def new
    @user = User.new 
  end

  def edit
  end

  def update
     if params[:commit] == "Save changes"
        if @user.update_attributes(user_params)
          flash[:success] = "Profile updated"
          redirect_to edit_user_path(@user)     
        else
          render 'edit'
        end
      elsif params[:commit] == "Update image"
        @user = User.find(params[:id])
        if user_params[:avatar] && @user.update_attribute(:avatar, user_params[:avatar])
          flash[:success] = "Profile picture has been successfully updated."
          redirect_to edit_user_path(@user) 
        else 
          flash[:danger] = "Image path is not valid."
          render 'edit'
        end
     end
    
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User is deleted."
    redirect_to users_url
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		sign_in @user
  		UserMailer.send_signup_email(@user).deliver
  		flash[:success] = "Welcome to the Bughouse Chess App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
