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
	end

	def update
		if @expense.update_attributes(expense_params)
	  		flash[:success] = "Expense updated"
	  		redirect_to show_expenses_path
	  	else
	  		render 'edit'
	  	end
	end

	def show
	end

	def index
	end

	def destroy
		@expense.destroy
		flash[:success] = "Expense deleted"
		redirect_to show_expenses_path
	end

	private

		def expense_params
			params.require(:expense).permit(:tag, :amount, :date_occurred)
		end

		def correct_information
			@user = current_user
			@budget = @user.budget
			if @budget
				@expenses = @user.budget.expenses
				@expense = @expenses.find_by(id: params[:id])
			else
				flash[:warning] = "Please create a budget before adding expenses."
				redirect_to current_user
			end
		end

end
