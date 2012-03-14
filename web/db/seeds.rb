password = "password"


User.populate(5) do |user|
  user.name = Faker::Name.name
  user.email = Faker::Internet.email
  user.password_salt = BCrypt::Engine.generate_salt
  user.password_hash = BCrypt::Engine.hash_secret(password, user.password_salt)
  user.is_dev = Random.rand(10) < 4
  user.about = Populator.sentences(2..4)
end

#App.populate(10) do |app|
 # app.name = Faker::
