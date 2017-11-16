class CronJob
  include Sidekiq::Worker
  def perform
    # stuff to do goes in here
  end
end