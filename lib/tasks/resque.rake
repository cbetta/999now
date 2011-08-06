require 'resque/tasks'
 
task "resque:setup" => :environment
 
desc "Run Resque workers on Heroku"
task "jobs:work" => ["resque:setup"] do
  ENV['QUEUE'] = 'alarms,authorisations'
  Rake::Task["resque:work"].invoke 
end