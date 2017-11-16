class StationStatusRecord < ApplicationRecord
  def created_at_s
    created_at.to_s(:short)
  end
end
