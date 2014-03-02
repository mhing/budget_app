class UsersController < ApplicationController
  before_action :signed_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def new
  	if !signed_in?
	  	@user = User.new
	else
		redirect_to root_url
	end
  end

  def show
  	@budget = @user.budget
  end

  def create
  	if !signed_in?
	  	@user = User.new(user_params)
	  	if @user.save
	  		sign_in @user
	  		flash[:success] = "Welcome to BUDGET.IT #{@user.name}"
	  		redirect_to @user
	  	else
	  		render 'new'
	  	end
	else
		redirect_to root_url
	end
  end

  def edit
  end

  def update
  	if @user.update_attributes(user_params)
  		flash[:success] = "Profile updated"
  		redirect_to @user
  	else
  		render 'edit'
  	end
  end

  def destroy
	User.find(params[:id]).destroy
	flash[:success] = "User deleted."
	redirect_to root_url
  end

  private 

  	def user_params
  		params.require(:user).permit(:name, :email, :password,
                                     :password_confirmation)
  	end

  	# Before filters

  	def correct_user
  		@user = User.find(params[:id])
  		raise ActiveRecord::RecordNotFound if @user.nil?
  		redirect_to(root_url) unless current_user?(@user)
  	end

  	rescue_from ActiveRecord::RecordNotFound do
	    redirect_to root_url
	end
end
