Rails.application.routes.draw do
  devise_for :users

  resource :bookings do
    collection do
      get :scheduled
      get :user
    end
  end

  root to: 'bookings#index'
end
