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
end
