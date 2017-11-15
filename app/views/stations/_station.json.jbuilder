json.extract! station, :id, :number, :coordinate_x, :coordinate_y, :name, :created_at, :updated_at
json.url station_url(station, format: :json)
