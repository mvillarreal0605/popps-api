Rails.application.routes.draw do
  get 'inquiries/create'
  root to: 'pages#home'

  resources :inquiries, only: :create

  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :user_relay_registrations, only: [ :index, :show, :update, :create, :destroy ]
      resources :users, only: [ :index, :show, :update, :create, :destroy ]
      resources :pitches, only: [ :index, :show, :update, :create, :destroy ]
      resources :sessions, only: [ :index, :show, :update, :create, :destroy ]
    end
  end
end
