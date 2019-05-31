Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  devise_scope :user do
    authenticated :user do
      root 'home#index'
    end
    unauthenticated do
      root 'devise/sessions#new'
    end
  end
  resources :stations
  resources :bikes
  resources :rentals
end
