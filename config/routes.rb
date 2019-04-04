Rails.application.routes.draw do
  resources :users
  resources :repositories
  resources :branches
end
