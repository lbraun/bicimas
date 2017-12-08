namespace :data do
  desc "Backs up and deletes old records"
  task archive: :environment do
    raise "ONLY RUN THIS LOCALLY!" unless Rails.env == "development"

    # Start a heroku backup
    puts "\n>> Capturing backup..."
    `heroku pg:backups:capture`

    # Download backup
    puts "\n>> Downloading backup..."
    `heroku pg:backups:download`

    # Move backup to backups folder
    archive_folder_path = "~/Google\\ Drive/Bicimas\\ Data/backups"
    timestamp = Time.now.to_formatted_s(:number)
    backup_path = "#{archive_folder_path}/backup_#{timestamp}.dump"

    puts "\n>> Moving backup to #{backup_path}..."
    `mv latest.dump #{backup_path}`

    # Kick off rake task to clear out old records
    puts "\n>> Starting remote task to clear out old records..."
    `heroku run rake data:delete_old_records`

    puts "\n>> Done!"
  end

  desc "Deletes stations status records that are older than one week"
  task delete_old_records: :environment do
    puts "Deleting records older than 1 week..."
    delete_count = StationStatusRecord.where("created_at < ?", Date.today - 1.week).delete_all

    puts "Done! Deleted #{delete_count} record(s)."
  end
end
