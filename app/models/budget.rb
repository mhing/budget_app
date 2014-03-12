class Budget < ActiveRecord::Base
	before_validation :strip_commas

	belongs_to :user

	has_many :expenses, dependent: :destroy
	has_many :incomes, dependent: :destroy

	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 40 }

	VALID_AMOUNT_REGEX = /\d{0,6}(\.\d{0,2})/

	validates :amount, presence: true, 
					   format: { with: VALID_AMOUNT_REGEX }

	validates_format_of :amount, :with => VALID_AMOUNT_REGEX


	def strip_commas
		self.amount = self.amount.to_s.gsub('/,/', '').to_f
	end
end
