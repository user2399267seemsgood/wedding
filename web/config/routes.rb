# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'switch_locale/:locale', to: 'welcome#switch_locale', as: :switch_locale
  get 'welcome/index'

  resources :guests do
    resources :plus_ones
    member do
      get :confirm
      patch :complete
    end
  end
  get "guest_exists/:first_name/:last_name", to: "guests#new_exists", as: :guest_exists
  get "guest_not_found", to: "guests#not_found", as: :guest_not_found

  root 'welcome#index'

  get 'gifts/payment_options', to: 'gifts#payment_options'

  resources :gifts, only: [:index] do
    member do
      post :claim
    end
  end

  namespace :admin do
    resources :gifts, only: []
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
