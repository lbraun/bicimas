class WelcomeController < ApplicationController
  def index
    @favorite_stations = Station.where(id: favorite_station_ids)
  end
end
