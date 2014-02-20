namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@example.com",
                 password: "foobar",
                 password_confirmation: "foobar")

    amount = 545.00

    10.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@example.com"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all
    users.each do |user| 
      amount = 145 + (user.id * 5.15)
      user.create_budget(amount: amount)
    end
  end
end