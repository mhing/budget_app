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
	end

	def update
		if @income.update_attributes(income_params)
	  		flash[:success] = "Income updated"
	  		redirect_to show_incomes_path
	  	else
	  		render 'edit'
	  	end
	end

	def show
	end

	def destroy
		@income.destroy
		flash[:success] = "Income deleted"
		redirect_to show_incomes_path
	end

	private

		def income_params
			params.require(:income).permit(:tag, :amount, :date_occurred)
		end

		def correct_information
			@user = current_user
			@budget = @user.budget
			if @budget
				@incomes = @user.budget.incomes
				@income = @incomes.find_by(id: params[:id])
			else
				flash[:warning] = "Please create a budget before adding incomes."
				redirect_to current_user
			end
		end
end
