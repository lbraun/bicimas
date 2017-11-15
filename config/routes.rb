Rails.application.routes.draw do
  resources :station_status_records
  resources :stations do
    get 'refresh', on: :collection
  end
end
