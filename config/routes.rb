Rails.application.routes.draw do
  resources :categories
  resources :workers
  root 'pages#home'
  resources :services
end
