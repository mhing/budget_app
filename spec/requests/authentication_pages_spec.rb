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
			before { click_button"Sign in" }

			it { should have_title('Sign in') }
			#it { should have_selector('div.alert.alert-error') }

			describe "after visiting another page" do
				before { click_link "Budget Planner" }
				it { should_not have_selector('div.alert.alert-error') }
			end
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before { sign_in user }

			it { should have_title(user.name) }
			it { should have_link('Settings') }
			it { should have_link('Sign Out') }
			it { should_not have_link('Sign in', href: root_path) }

			describe "followed by signout" do
				before { click_link "Sign Out" } 
				it { should have_button('Sign in') }
				it { should have_link('Sign up!') }
			end
		end
	end

	describe "authorization" do

		describe "for non-signed-in users" do
			let(:user) { FactoryGirl.create(:user) }

			describe "in the Users controller" do

				describe "visiting the edit page" do
					before { visit edit_user_path(user) }
					it { should have_title('Sign in') }
				end

				describe "submitting to the update action" do
					before { patch user_path(user) }
					specify { expect(response).to redirect_to(root_path) }
				end
			end

			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					fill_in "Email", with: user.email
					fill_in "Password", with: user.password
					click_button "Sign in"
				end

				describe "after signing in" do
					it "should render the desired protected page" do
						expect(page).to have_title('Edit User')
					end
				end
			end

			describe "submitting a DELETE request to the Users#destroy action" do
				before { delete user_path(user) }

				specify { expect(response).to redirect_to root_url}
			end

			describe "in the Budgets controller" do

				describe "submitting to the create action" do
					before { post budgets_path }
					specify { expect(response).to redirect_to(root_url) }
				end

				describe "submitting to the destroy action" do
					before { delete budget_path(FactoryGirl.create(:budget)) }
					specify { expect(response).to redirect_to(root_url) }
				end
			end
		end

		describe "as wrong user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
			before { sign_in user, no_capybara: true }

			describe "submitting a GET request to the User#edit action" do
				before { get edit_user_path(wrong_user) }
				specify { expect(response.body).not_to match(full_title('Edit user')) }
				specify { expect(response).to redirect_to(root_url) }
			end

			describe "submitting a PATCH request to the Users#update action" do
				before { patch user_path(wrong_user) }
				specify { expect(response).to redirect_to(root_url) }
			end

		end
	end
end
