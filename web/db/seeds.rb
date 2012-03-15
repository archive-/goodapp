password = "password"

User.populate(100) do |user|
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
App.populate(40) do |app|
  app.name = Populator.words(2)
end

# TODO PROBLEM some apps aren't linked...
# should be in loop above where they are asigned

# not sure if this should be App or user
# and problem here is that we don't want the same app to be
# assigned to 2 different devs [but more then one app can be assigned to one dev]
AppOwnership.populate(5) do |app_ownership|
  app_ownership.user_id = 1..5
  app_ownership.app_id = 1..10
end

# not sure is this should be App or user
# this should work fine since different users can use multiple apps
# question: do we only do this for basic users or devs as well?
# if we do not do this for devs, we would have to put a check there to make sure that user != dev
AppUsage.populate(5) do |app_usage|
  app_usage.user_id = 1..5
  app_usage.app_id = 1..10
end
