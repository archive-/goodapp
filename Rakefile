#!/usr/bin/env rake

task :default => 'test:all'

namespace :test do
  desc "Run all tests"
  task :all => [:trust, :web]

  desc "Test endorsement trust calculation script"
  task :trust do
    puts `rspec spec/trust_spec.rb`
  end

  desc "Test website"
  task :web do
    # call rake test in web
    `cd web; rake test`
    # load 'web/Rakefile'
  end
end
