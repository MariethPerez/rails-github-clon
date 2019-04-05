Rails.application.routes.draw do
  resources :users do
    resources :repositories, only: :index do
      resources :branches, only: :index
    end
  end
  resources :repositories
  resources :branches
end
