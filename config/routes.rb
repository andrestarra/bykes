Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'home/index'
  root 'home#index'
  resources :stations, only: [:index, :show] do
    resources :rentals, except: [:index]
  end
  resources :records
  put '/records/:id/finalize', to: 'records#finalize'
  resources :rentals, only: [:index]
end
