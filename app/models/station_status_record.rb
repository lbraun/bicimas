class StationStatusRecord < ApplicationRecord
  scope :recent, -> { where("(#{created_at_sql}) > (#{current_timestamp_sql} - interval '12 hours')").order("EXTRACT(HOUR FROM #{created_at_sql}), EXTRACT(MINUTE FROM #{created_at_sql})") }
  scope :from_today, -> { where("DATE(#{created_at_sql}) = DATE(#{current_timestamp_sql})") }
  scope :from_weekends, -> { where("EXTRACT(DOW FROM #{created_at_sql}) IN (0,6)") }
  scope :from_week_days, -> { where("EXTRACT(DOW FROM #{created_at_sql}) NOT IN (0,6)") }

  def self.from_hour(hour)
    where("? = EXTRACT(HOUR FROM #{created_at_sql})", hour)
  end

  def self.postgres_time_zone
    # https://stackoverflow.com/questions/23420859/how-to-map-rails-timezone-names-to-postgresql
    ActiveSupport::TimeZone.find_tzinfo(Time.zone.name).identifier
  end

  def self.created_at_sql
    # Time zones suck!
    # The created_at timestamp is in UTC but is not stored with its zone in the database.
    # First we mark it as UTC, then convert it to the app's default zone.
    "(created_at AT TIME ZONE 'UTC' AT TIME ZONE '#{postgres_time_zone}')"
  end

  def self.current_timestamp_sql
    # Time zones suck!
    # The postgres CURRENT_TIMESTAMP method returns the current time in the server's time zone.
    # We convert it to the app's default zone, in case the server is in a different zone.
    "CURRENT_TIMESTAMP AT TIME ZONE '#{postgres_time_zone}'"
  end

  def created_at_s
    created_at.to_s(:short)
  end
end
