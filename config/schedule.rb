# Use this file to easily define all of your cron jobs.
# Learn more: http://github.com/javan/whenever

job_type :sidekiq, "cd :path && :environment_variable=:environment bundle exec sidekiq-client push :task :output"

every 30.minutes, :roles => [:app] do
  sidekiq "CronJob"
end