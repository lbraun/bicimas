desc "Pull data from bicicas website every 10 minutes"
task :pull_data do
  puts "Attempting to pull fresh data..."
  puts "Success!" if Station.pull_data
end