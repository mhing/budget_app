require 'spec_helper'

describe "Static pages" do

	subject { page }

  describe "Home page" do
  	before { visit root_path }

	it { should have_content('Budget Planner') }
    it { should have_title("Budget Planner") }
    it { should_not have_title('| Home') }

  end

  describe "About page" do
  	before { visit about_path }

	it { should have_content('About Budget Planner') }
    it { should have_title("Budget Planner | About") }

  end

end