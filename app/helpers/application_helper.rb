module ApplicationHelper

	# Get full title for site
	def full_title(page_title)
		base_title = "Budget.it"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def new_income_page?
		request.fullpath == new_income_path
	end

	def new_expense_page?
		request.fullpath == new_expense_path
	end

	def expenses_total
		sum = 0
		user = current_user
		budget = user.budget
		if !budget.nil?
			expenses = budget.expenses
			if !expenses.blank?
				expenses.each do |exp|
					sum += exp.amount
				end
			end
		end
		sum = -sum
	end

	def incomes_total
		sum = 0
		user = current_user
		budget = user.budget
		if !budget.nil?
			incomes = budget.incomes
			if !incomes.blank?
				incomes.each do |inc|
					sum += inc.amount
				end
			end
		end
		sum
	end

	def net_worth
		net = incomes_total + expenses_total
	end

end
