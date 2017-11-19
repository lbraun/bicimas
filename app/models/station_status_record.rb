class StationStatusRecord < ApplicationRecord
  scope :from_today, -> { where('DATE(created_at) = CURRENT_DATE') }
  scope :from_weekends, -> { where('EXTRACT(DOW FROM created_at) IN (0,6)') }
  scope :from_week_days, -> { where('EXTRACT(DOW FROM created_at) NOT IN (0,6)') }

  def self.from_hour(hour)
    # Subtract 1 hour to adjust for UTC conversion
    where("#{hour - 1} = EXTRACT(HOUR FROM created_at)")
  end

  def created_at_s
    created_at.to_s(:short)
  end
end
