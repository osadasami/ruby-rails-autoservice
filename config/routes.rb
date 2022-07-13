Rails.application.routes.draw do
  root 'services#index'
  resources :categories
  resources :workers
  resources :services
  resources :orders do
    get :export, on: :collection, defaults: { format: :xlsx }
  end
end
