FactoryGirl.define do
  pw = Faker::Internet.password
  factory :user do
    email Faker::Internet.email
    password pw
    password_confirmation pw
    confirmed_at Date.today
  end
end
