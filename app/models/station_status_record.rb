class StationStatusRecord < ApplicationRecord
  scope :from_today, -> { where('DATE(created_at) = CURRENT_DATE') }
  scope :from_weekends, -> { where('EXTRACT(DOW FROM created_at) IN (0,6)') }
  scope :from_week_days, -> { where('EXTRACT(DOW FROM created_at) NOT IN (0,6)') }

  def self.from_hour(hour)
    # https://stackoverflow.com/questions/23420859/how-to-map-rails-timezone-names-to-postgresql
    postgres_time_zone = ActiveSupport::TimeZone.find_tzinfo(Time.zone.name).identifier
    where("? = EXTRACT(HOUR FROM (created_at AT TIME ZONE ?))", hour, postgres_time_zone)
  end

  def created_at_s
    created_at.to_s(:short)
  end
end
