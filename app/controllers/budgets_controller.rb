class BudgetsController < ApplicationController
	before_action :signed_in_user
	before_action :correct_budget, only: [:edit, :update, :show, :destroy]

	def new
		@budget = Budget.new
	end

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

	def edit
	end

	def update
		if @budget.update_attributes(budget_params)
	  		flash[:success] = "Budget updated"
	  		redirect_to show_budget_path
	  	else
	  		render 'edit'
	  	end
	end

	def destroy
		@budget.destroy
		redirect_to current_user
	end

	def show
		@user = current_user
		render 'show'
	end

	private

		def budget_params
			params.require(:budget).permit(:name, :amount)
		end

		def correct_budget
			@budget = current_user.budget
		end

end