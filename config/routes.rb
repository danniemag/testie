Rails.application.routes.draw do
  devise_for :users

  resources :bookings, only: :index do
    collection do
      get :details
      get :scheduled
    end
  end

  root to: 'bookings#index'
end
