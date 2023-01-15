Rails.application.routes.draw do
  namespace :api do
    resources :vessels, only: [:index, :show, :create, :update]
    resources :voyages, only: [:index, :show, :create, :update]
  end
end
