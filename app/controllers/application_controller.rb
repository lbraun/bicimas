class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def favorite_station_ids
    return [] unless cookies[:favorite_station_ids]
    cookies[:favorite_station_ids].split('&').map(&:to_i)
  end
end
