require "resque/tasks"
require "resque_scheduler/tasks"

namespace :resque do
  task :setup do
    ENV["QUEUE"] = "*"
  end
end
