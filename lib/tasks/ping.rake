require 'net/http'

namespace :ping do
  desc "Pull data every 10 minutes"
  task :refresh do
    puts "Attempting to pull fresh data..."

    if ENV['BICIMAS_REFRESH_URL']
      puts "Sending ping to #{ENV['BICIMAS_REFRESH_URL']}..."

      uri = URI(ENV['BICIMAS_REFRESH_URL'])
      response = Net::HTTP.get_response(uri)

      puts response.inspect
    else
      puts "Error: URL to ping is not defined"
    end
  end
end
