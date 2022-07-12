Rails.application.routes.draw do
  root 'services#index'
  resources :categories
  resources :workers
  resources :services
end
