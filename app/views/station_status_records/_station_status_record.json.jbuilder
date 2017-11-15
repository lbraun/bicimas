json.extract! station_status_record, :id, :station_id, :bikes_total, :bikes_available, :anchors, :last_seen, :online, :ip, :number_loans, :created_at, :updated_at
json.url station_status_record_url(station_status_record, format: :json)
