Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :users
  resources :rooms
  resources :reservations
  get 'search' => 'rooms#search'
end
