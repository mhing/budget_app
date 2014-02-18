class SessionsController < ApplicationController
	
	def new
		if signed_in?
			redirect_to current_user
		end
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_back_or user
		else
			flash[:error] = 'Invalid email/password'
			#render 'new'
			redirect_to root_url
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

end
