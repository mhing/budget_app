require 'spec_helper'

describe Budget do

	let(:user) { FactoryGirl.create(:user) }
	before { @budget = user.build_budget(amount: 150.50) }

	subject { @budget }

	it { should respond_to(:amount) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	its(:user) { should eq user }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @budget.user_id = nil }
		it { should_not be_valid }
	end

	describe "with blank amount" do
		before { @budget.amount = " " }
		it { should_not be_valid }
	end

	describe "with negative budget" do
		before { @budget.amount = -100 }
		it { should_not be_valid }
	end

	describe "with non numbers" do
		before { @budget.amount = "asdf" }
		it { should_not be_valid }
	end
end
