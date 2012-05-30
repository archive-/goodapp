# config/initializers/application.rb

Dir[Rails.root + "lib/**/*.rb"].each do |file|
  require file
end
