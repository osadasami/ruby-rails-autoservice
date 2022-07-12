Rails.application.routes.draw do
  resources :workers
  root 'pages#home'
  resources :services
end
