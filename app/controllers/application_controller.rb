class ApplicationController < ActionController::Base
	before_filter :redirect_if_old


	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	include SessionsHelper

	protected

		def redirect_if_old
			if request.host == 'budgetplanner.herokuapp.com'
				redirect_to "http://budget-it.herokuapp.com#{request.request_uri}", :status => :moved_permanently
			end
		end
end
