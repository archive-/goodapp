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
Key.destroy_all

digest = User.new.send(:password_digest, "blabla")

User.populate(1) do |user|
  user.name = 'TJ Koblentz'
  user.email = 'tj.koblentz@gmail.com'
  user.encrypted_password = digest
  user.about = "Hi, I'm TJ."
  user.endorsement_rating = 0
  user.confirmed_at = "2012-06-06 06:17:52"
  user.confirmation_sent_at = "2012-06-06 06:17:46"    
end

User.populate(1) do |user|
  user.name = 'Yulia Dubinina'
  user.email = 'skiswithtwotips@gmail.com'
  user.encrypted_password = digest
  user.about = "Hi, I'm Yulia."
  user.endorsement_rating = 0 
  user.confirmed_at = "2012-06-06 06:17:52" 
  user.confirmation_sent_at = "2012-06-06 06:17:46"  
end

User.populate(1) do |user|
  user.name = 'Victor Moreira'
  user.email = 'montesinnos@gmail.com'
  user.encrypted_password = digest
  user.about = "Hi, I'm Victor."
  user.endorsement_rating = 0
  user.confirmed_at = "2012-06-06 06:17:52"
  user.confirmation_sent_at = "2012-06-06 06:17:46"        
end

User.populate(1) do |user|
  user.name = 'Jasper Fredrickson'
  user.email = 'jrf@umail.ucsb.edu'
  user.encrypted_password = digest
  user.about = "Hi, I'm Jasper."
  user.endorsement_rating = 0 
  user.confirmed_at = "2012-06-06 06:17:52"
  user.confirmation_sent_at = "2012-06-06 06:17:46"       
end

# Creates account for Regression test
User.populate(1) do |user|
  user.name = 'Regression Test'
  user.email = 'regression@test.com'
  user.encrypted_password = digest
  user.about = "Test master."
  user.endorsement_rating = 0 
  user.confirmed_at = "2012-06-06 06:17:52"
  user.confirmation_sent_at = "2012-06-06 06:17:46"       
end

# populate some other users
User.populate(5) do |user|
  user.name = Faker::Name.name
  user.email = Faker::Internet.email
  user.encrypted_password = digest
  user.about = Populator.sentences(2..4)
  user.endorsement_rating = 0 
  user.confirmed_at = "2012-06-06 06:17:52"  
  user.confirmation_sent_at = "2012-06-06 06:17:46"  
end

# populate keys
Key.populate(8) do |key|
  key.rating = 1..100
  key.title = "testing"
  key.user_id = 1..8
  key.kee = "test"
  key.proper = true
  key.user_id = 1..10 
end

# populate apps
App.populate(10) do |app|
  app.title = Populator.words(1..2)
  app.key_id = 1..8
  app.proper = true
  app.aid = 1..8 
  app.status = 100
  app.version = 1.1...1.3
end

