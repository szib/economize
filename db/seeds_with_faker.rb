users = []
50.times do
  hash = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: '111111',
    password_confirmation: '111111'
  }
  users << hash
end
User.create users

