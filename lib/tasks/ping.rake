require 'net/http'

namespace :ping do
  desc "Pull data from bicicas website every 10 minutes"
  task :refresh do
    puts "Attempting to pull fresh data..."

    if ENV['URL']
      puts "Sending ping..."

      uri = URI(ENV['URL'])
      Net::HTTP.get_response(uri)

      puts "Success!"
    end
  end
end