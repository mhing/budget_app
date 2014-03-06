class Budget < ActiveRecord::Base
	belongs_to :user

	has_many :expenses, dependent: :destroy

	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 40 }

	VALID_AMOUNT_REGEX = /\d{0,4}(\.\d{0,2})/

	validates :amount, presence: true, 
					   numericality: { greater_than_or_equal_to: 0 }, 
					   format: { with: VALID_AMOUNT_REGEX }
end
