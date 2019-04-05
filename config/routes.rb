Rails.application.routes.draw do
  resources :users
  resources :repositories
  resources :branches
  resources :pull_requests
  resources :issues
end
