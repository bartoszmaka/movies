Rails.application.routes.draw do
  root 'statistics#index'
  resources :actors
  resources :movies
  resources :genres
  resources :statistics, only: :index
end

