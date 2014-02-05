require 'spec_helper'

describe "Static pages" do

	subject { page }

  describe "Home page" do
  	before { visit root_path }

	it { should have_content('Budget Planner') }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }

  end

  describe "About page" do
  	before { visit about_path }

	it { should have_content('About Budget Planner') }
    it { should have_title(full_title('About')) }

  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About'))
    click_link "Budget Planner"
    click_link "Sign up!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "Budget Planner"
    expect(page).to have_title(full_title(''))
  end

end