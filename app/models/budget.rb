class Budget < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true

	VALID_AMOUNT_REGEX = /\d{0,4}(\.\d{0,2})/

	validates :amount, presence: true, 
					   numericality: { greater_than_or_equal_to: 0 }, 
					   format: { with: VALID_AMOUNT_REGEX }
end
