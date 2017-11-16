Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :station_status_records
  resources :stations do
    get 'refresh', on: :collection
  end
end
