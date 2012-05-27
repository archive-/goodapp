# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# to run do: rake db:seed

User.destroy_all
App.destroy_all

digest = User.new.send(:password_digest, "blabla")

# TODO less hacky
=begin
def finish_seeding_user(user, roles=[])
  user.confirmed_at = Time.now
  user.save
  roles.each do |role|
    user.add_role role
  end
end
=end

User.populate(1) do |user|
  user.name = 'TJ Koblentz'
  user.email = 'tj.koblentz@gmail.com'
  user.encrypted_password = digest
  user.about = "Hi, I'm TJ."
end
# finish_seeding_user(User.last, [:admin, :dev])

User.populate(1) do |user|
  user.name = 'Yulia Dubinina'
  user.email = 'skiswithtwotips@gmail.com'
  user.encrypted_password = digest
  user.about = "Hi, I'm Yulia."
end
# finish_seeding_user(User.last, [:admin, :dev])

User.populate(1) do |user|
  user.name = 'Victor Moreira'
  user.email = 'montesinnos@gmail.com'
  user.encrypted_password = digest
  user.about = "Hi, I'm Victor."
end
# finish_seeding_user(User.last, [:admin, :dev])

User.populate(1) do |user|
  user.name = 'Jasper Fredrickson'
  user.email = 'jrf@umail.ucsb.edu'
  user.encrypted_password = digest
  user.about = "Hi, I'm Jasper."
end
# finish_seeding_user(User.last, [:admin, :dev])

# Creates account for Regression test
User.populate(1) do |user|
  user.name = 'Regression Test'
  user.email = 'regression@test.com'
  user.encrypted_password = digest
  user.about = "Test master."
end
# finish_seeding_user(User.last, [:admin, :dev])

User.populate(25) do |user|
  user.name = Faker::Name.name
  user.email = Faker::Internet.email
  user.encrypted_password = digest
  user.about = Populator.sentences(2..4)
end
