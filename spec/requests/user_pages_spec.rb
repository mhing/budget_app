require 'spec_helper'

describe "UserPages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit }.not_to change(User, :count)
			end

			describe "after submission" do
				before { click_button submit }

				it { should have_title('Sign up') }
				it { should have_content('error') }
			end
	    end

	    describe "with valid information" do
			before do
				fill_in "Name",         with: "Example User"
				fill_in "Email",        with: "user@example.com"
				fill_in "Password",     with: "foobar"
				fill_in "Confirm Password", with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by(email: 'user@example.com') }

				it { should have_link('Sign Out') }
				it { should have_content(user.name) }
				it { should have_selector('div.alert.alert-success', text: 'Welcome') }
			end
	    end
	end

	describe "budget home page" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit user_path(user)
		end

		it { should have_content(user.name) }
		it { should have_content("Expenses") }
		it { should have_content("Income") }
		it { should have_content("Budget") }
	end

	describe "edit" do
		let(:user) { FactoryGirl.create(:user) }
		before do
			sign_in user
			visit edit_user_path(user)
		end

		describe "page" do
			it { should have_content("Account Settings") }
			it { should have_title("Edit User") }
			it { should have_button("Delete My Account") }
		end

		describe "with invalid information" do
			before { click_button "Save Email" }

			it { should have_content('error') }
		end

		describe "with valid information" do
			describe "update email" do
				let(:new_name)  { "New Name" }
				let(:new_email) { "new@example.com" }
				before do
					fill_in "Name",             with: new_name
					fill_in "Email",            with: new_email
					fill_in "New Password",         with: user.password
					fill_in "Confirm New Password", with: user.password
					click_button "Save Email"
				end

				it { should have_title(new_name) }
				it { should have_selector('div.alert.alert-success') }
				it { should have_link('Sign Out', href: signout_path) }

				specify { expect(user.reload.name).to  eq new_name }
				specify { expect(user.reload.email).to eq new_email }
			end
		end

		describe "account deletion" do
			it "should be able to delete their account" do
				expect { click_button "Delete My Account" }.to change(User, :count).by(-1)
			end
		end
	end
end
