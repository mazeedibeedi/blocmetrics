FactoryGirl.define do
  require 'faker'
  factory :registered_application do
    name Faker::Internet.domain_word
    url Faker::Internet.url
    user
  end
end
