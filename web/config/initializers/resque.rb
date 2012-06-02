require "resque"
require "resque_scheduler"
require "resque/server"
require "resque_scheduler/server"

Resque.redis = "localhost:6379"
Resque.schedule = YAML.load_file(File.join(Rails.root, "config/resque_schedule.yml"))
