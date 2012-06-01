require "resque/tasks"
require "resque_scheduler/tasks"

namespace :resque do
  task :setup do
    require "resque"
    require "resque_scheduler"
    require "resque/scheduler"
    Resque.redis = "localhost:6379"
    # don't need a dynamic schedule
    # Resque::Scheduler.dynamic = true
    # TODO schedule github syncs, etc.
    # Resque.schedule = YAML.load_file("resque_schedule.yml")
  end
end
