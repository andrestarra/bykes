Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
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
  resources :rentals
  scope '/admin' do
    resources :stations, :bikes
  end
end
