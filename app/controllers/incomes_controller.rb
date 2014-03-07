class IncomesController < ApplicationController
	before_action :signed_in_user
	before_action :correct_information

	def new
		@income = Income.new
	end

	def create
		@income = current_user.budget.incomes.build(income_params)
		if @income.save
			flash[:success] = "Income added!"
		else
			flash[:error] = "Error creating income."
		end
		render 'show'
	end

	def edit
		@income = @incomes.find_by(id: params[:id])
	end

	def update
		@income = @incomes.find_by(id: params[:id])
		if @expense.update_attributes(income_params)
	  		flash[:success] = "Income updated"
	  		redirect_to show_incomes_path
	  	else
	  		render 'edit'
	  	end
	end

	def show
	end

	private

		def income_params
			params.require(:income).permit(:tag, :amount)
		end

		def correct_information
			@user = current_user
			@budget = @user.budget
			@incomes = @user.budget.incomes
		end
end
