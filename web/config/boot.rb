require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

ENV['GMAIL_EMAIL']    = "goodapp.confirm@gmail.com"
ENV['GMAIL_PASSWORD'] = ">2q3&X__~@s/"

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
