Rails.application.routes.draw do
  namespace :api do
    resources :vessels, only: [:index, :show, :create, :update] do
      get :current_voyage, on: :member
    end
    resources :voyages, only: [:index, :show, :create, :update]
  end
end
