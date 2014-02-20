FactoryGirl.define do
  factory :user do
  	sequence(:name) { |n| "Person #{n}" }
  	sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"
  end

  factory :budget do
  	amount 150.54
  	user
  end
end