Rails.application.routes.draw do
  devise_for :users

  resources :bookings, only: %i[index new create] do
    collection do
      post :check_slots, as: 'check_slots'
      get :details
      get :scheduled
    end
  end

  root to: 'bookings#index'
end
