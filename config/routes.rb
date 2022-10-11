Rails.application.routes.draw do
  resources :products
  resources :posts
  # devise_for :users
  # devise_for :users, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks" }
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_for :accounts
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
