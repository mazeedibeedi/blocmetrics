10.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password
  )
end

users = User.all

50.times do
  RegisteredApplication.create!(
    name: Faker::Internet.domain_word,
    url: Faker::Internet.url,
    user: users.sample
  )
end

registered_applications = RegisteredApplication.all

100.times do
  Event.create!(
    name: Faker::RickAndMorty.location,
    registered_application: registered_applications.sample
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} applications created"
puts "#{Event.count} events created"
