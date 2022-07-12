Rails.application.routes.draw do
  resources :orders
  root 'services#index'
  resources :categories
  resources :workers
  resources :services
end
