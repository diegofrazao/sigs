Rails.application.routes.draw do
  get "orders/report", to: 'orders#report'
  resources :orders
  resources :services
  root to: 'application#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
