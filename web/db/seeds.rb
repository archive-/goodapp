# to run do: rake db:seed

User.destroy_all
App.destroy_all
AppOwnership.destroy_all
AppUsage.destroy_all

digest = User.new.send(:password_digest, "blabla")

# TODO less hacky
def finish_seeding_user(user, roles=[])
  user.confirmed_at = Time.now
  user.save
  roles.each do |role|
    user.add_role role
  end
end

User.populate(1) do |user|
  user.name = 'Clark Kent'
  user.email = 'clark@example.com'
  user.encrypted_password = digest
  user.about = "Hi, I'm Clark."
end
finish_seeding_user(User.last, [:admin])

User.populate(1) do |user|
  user.name = 'TJ Koblentz'
  user.email = 'tj.koblentz@gmail.com'
  user.encrypted_password = digest
  user.about = "Hi, I'm TJ."
end
finish_seeding_user(User.last, [:admin])

User.populate(1) do |user|
  user.name = 'Yulia Dubinina'
  user.email = 'skiswithtwotips@gmail.com'
  user.encrypted_password = digest
  user.about = "Hi, I'm Yulia."
end
finish_seeding_user(User.last, [:admin])

User.populate(1) do |user|
  user.name = 'Victor Moreira'
  user.email = 'montesinnos@gmail.com'
  user.encrypted_password = digest
  user.about = "Hi, I'm Victor."
end
finish_seeding_user(User.last, [:admin])

User.populate(1) do |user|
  user.name = 'Jasper Fredrickson'
  user.email = 'jrf@umail.ucsb.edu'
  user.encrypted_password = digest
  user.about = "Hi, I'm Jasper."
end
finish_seeding_user(User.last, [:admin])

# user testing
User.populate(1) do |user|
  user.name = 'Normal Example'
  user.email = 'normal@example.com'
  user.encrypted_password = digest
  user.about = "Hi, I'm John."
end
finish_seeding_user(User.last)

# creating an account for testing -- need to give this user apps
User.populate(1) do |user|
  user.name = 'Jenna Bryant'
  user.email = 'jenna@example.com'
  user.encrypted_password = digest
  user.about = "Hi, I'm Jenna."
end
finish_seeding_user(User.last)

# Creates account for Regression test
User.populate(1) do |user|
    user.name = 'Regression Test'
    user.email = 'regression@test.com'
    user.encrypted_password = User.new.send(:password_digest, "test123")
    user.about = "Test master."
    user.confirmed_at = Time.now
end

User.populate(50) do |user|
  user.name = Faker::Name.name
  user.email = Faker::Internet.email
  user.encrypted_password = digest
  user.about = Populator.sentences(2..4)
end
User.last(50).each do |user|
  user.add_role(:dev) if Random.rand(10) < 4
  finish_seeding_user(user)
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
