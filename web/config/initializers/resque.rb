require "resque/server"
require "resque_scheduler"
require "resque_scheduler/server"

Resque.redis = "localhost:6379"
