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
end
