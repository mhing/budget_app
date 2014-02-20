require 'spec_helper'

describe "BudgetPages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before do
		sign_in user
		visit root_path
	end

	describe "budget creation" do
		before do
			#click_link "Budget"
			click_link "+ Add Budget"
		end

		describe "with invalid information" do

			it "should not create a budget" do
				expect { click_button "Save"}.not_to change(Budget, :count)
			end

			describe "error messages" do
				before { click_button "Save" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			before { fill_in 'budget_amount', with: 150.95 }
			it "should create a budget" do
				expect { click_button "Save" }.to change(Budget, :count).by(1)
			end
		end
	end
end