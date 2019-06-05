Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'home/index'
  devise_scope :user do
    authenticated :user do
      root 'home#index'
    end
    unauthenticated do
      root 'devise/sessions#new'
    end
  end
  devise_scope :admin do
    root 'home#index'
  end
  resources :rentals
  resources :stations, only: [:index]
end
