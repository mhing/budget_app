class BudgetsController < ApplicationController
	before_action :signed_in_user

	def create
		@budget = current_user.build_budget(budget_params)
		if @budget.save
			flash[:success] = "Budget created!"
			redirect_to current_user
		else
			flash[:error] = "Error creating budget."
			render 'static_pages/budget'
		end
	end

	def destroy
	end

	private

		def budget_params
			params.require(:budget).permit(:amount)
		end

end