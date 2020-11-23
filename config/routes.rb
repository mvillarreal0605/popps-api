Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :user_relay_registrations, only: [ :index, :show, :update, :create, :destroy ]
      resources :users, only: [ :index, :show, :update, :create, :destroy ]
      resources :pitches, only: [ :index, :show, :update, :create, :destroy ]
      resources :sessions, only: [ :index, :show, :update, :create, :destroy ]
    end
  end



end
