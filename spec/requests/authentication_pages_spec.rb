require 'spec_helper'

describe "AuthenticationPages" do
	subject { page }

	describe "signin page" do
		before { visit root_path }

		it { should have_content('Sign in') }
		it { should have_title('Sign in') }
	end

	describe "signin" do
		before { visit root_path }

		describe "with invalid information" do
			before { click_link "Sign in" }

			it { should have_title('Sign in') }
			#it { should have_selector('div.alert.alert-error') }

			describe "after visiting another page" do
				before { click_link "Budget Planner" }
				it { should_not have_selector('div.alert.alert-error') }
			end
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				visit root_path
				fill_in "Email", with: user.email.upcase
				fill_in "Password", with: user.password
				click_button "Sign in"
			end

			it { should have_link('Settings') }
			it { should have_link('Sign Out') }
			it { should_not have_link('Sign in', href: root_path) }

			describe "followed by signout" do
				before { click_link "Sign Out" } 
				it { should have_link('Sign in') }
			end
		end
	end
end
