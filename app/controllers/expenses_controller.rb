class ExpensesController < ApplicationController
  	before_action :signed_in_user
	before_action :correct_information

	def new
		@expense = Expense.new
	end

	def create
		@expense = current_user.budget.expenses.build(expense_params)
		if @expense.save
			flash[:success] = "Expense added!"
		else
			flash[:error] = "Error creating expense."
		end
		render 'show'
	end

	def edit
		@expense = @user.budget.expenses.first #figure out how to get the one passed into the path
	end

	def update
		@expense = @user.budget.expenses.first
		if @expense.update_attributes(expense_params)
	  		flash[:success] = "Expense updated"
	  		render 'show'
	  	else
	  		render 'edit'
	  	end
	end

	def show
	end

	def index
	end

	private

		def expense_params
			params.require(:expense).permit(:tag, :amount)
		end

		def correct_information
			@user = current_user
			@budget = @user.budget
			@expenses = @user.budget.expenses
		end

end
