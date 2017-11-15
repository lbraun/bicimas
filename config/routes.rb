Rails.application.routes.draw do
  resources :stations do
    get 'refresh', on: :collection
  end
end
