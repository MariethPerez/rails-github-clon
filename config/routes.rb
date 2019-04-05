Rails.application.routes.draw do
  resources :users do
    resources :repositories, only: :index
  end
  resources :repositories
  resources :branches
end
