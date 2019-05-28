Rails.application.routes.draw do
  devise_for :users, path: 'users'
  get 'home/index'
  root 'home#index'
end
