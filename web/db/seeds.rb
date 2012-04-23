# to run do: rake db:seed

User.destroy_all
App.destroy_all
AppOwnership.destroy_all
AppUsage.destroy_all

password = "blabla"

User.populate(1) do |user|
  user.name = 'Clark Kent'
  user.email = 'clart@example.com'
  user.password_salt = BCrypt::Engine.generate_salt
  user.password_hash = BCrypt::Engine.hash_secret(password, user.password_salt)
  user.is_dev = true
  user.about = "Hi, I'm Clark."
end

User.populate(1) do |user|
  user.name = 'TJ Koblentz'
  user.email = 'tj.koblentz@gmail.com'
  user.password_salt = BCrypt::Engine.generate_salt
  user.password_hash = BCrypt::Engine.hash_secret(password, user.password_salt)
  user.is_dev = true
  user.about = "Hi, I'm TJ."
end

User.populate(1) do |user|
  user.name = 'Yulia Dubinina'
  user.email = 'skiswithtwotips@gmail.com'
  user.password_salt = BCrypt::Engine.generate_salt
  user.password_hash = BCrypt::Engine.hash_secret(password, user.password_salt)
  user.is_dev = true
  user.about = "Hi, I'm Yulia."
end

User.populate(1) do |user|
  user.name = 'Victor Moreira'
  user.email = 'montesinnos@gmail.com'
  user.password_salt = BCrypt::Engine.generate_salt
  user.password_hash = BCrypt::Engine.hash_secret(password, user.password_salt)
  user.is_dev = true
  user.about = "Hi, I'm Victor."
end

User.populate(1) do |user|
  user.name = 'Jasper Fredrickson'
  user.email = 'jrf@umail.ucsb.edu'
  user.password_salt = BCrypt::Engine.generate_salt
  user.password_hash = BCrypt::Engine.hash_secret(password, user.password_salt)
  user.is_dev = true
  user.about = "Hi, I'm Jasper."
end

# user testing
User.populate(1) do |user|
  user.name = 'Normal Example'
  user.email = 'normal@example.com'
  user.password_salt = BCrypt::Engine.generate_salt
  user.password_hash = BCrypt::Engine.hash_secret('password', user.password_salt)
  user.is_dev = false
  user.about = "Hi, I'm John."
end

# creating an account for testing -- need to give this user apps
User.populate(1) do |user|
  user.name = 'Jenna Bryant'
  user.email = 'jenna@example.com'
  user.password_salt = BCrypt::Engine.generate_salt
  user.password_hash = BCrypt::Engine.hash_secret(password, user.password_salt)
  user.is_dev = true
  user.about = "Hi, I'm Jenna."
end

User.populate(50) do |user|
  user.name = Faker::Name.name
  user.email = Faker::Internet.email
  user.password_salt = BCrypt::Engine.generate_salt
  user.password_hash = BCrypt::Engine.hash_secret(password, user.password_salt)
  user.is_dev = Random.rand(10) < 4
  user.about = Populator.sentences(2..4)
end

# there should be other fields added to the app database
# version, description, type [apple, android, windows]
# that way we can generate more info

App.populate(1) do |app|
  app.name = "Angry Birds"
end

App.populate(40) do |app|
  app.name = Populator.words(2)
end

# TODO PROBLEM some apps aren't linked...
# should be in loop above where they are asigned

# not sure if this should be App or user
# and problem here is that we don't want the same app to be
# assigned to 2 different devs [but more then one app can be assigned to one dev]

AppOwnership.populate(1) do |app_ownership|
  app_ownership.user_id = 1..40
  app_ownership.app_id = 2
end

AppOwnership.populate(41) do |app_ownership|
  app_ownership.user_id = 1..50
  app_ownership.app_id = 1..40
end

App.populate(1) do |app|
  app.name = "Justice League Hero Finder"
end

AppOwnership.populate(1) do |app_ownership|
  app_ownership.user_id = 1
  app_ownership.app_id = 42
end

# not sure is this should be App or user
# this should work fine since different users can use multiple apps
# question: do we only do this for basic users or devs as well?
# if we do not do this for devs, we would have to put a check there to make sure that user != dev
AppUsage.populate(5) do |app_usage|
  app_usage.user_id = 1..50
  app_usage.app_id = 1..40
end
