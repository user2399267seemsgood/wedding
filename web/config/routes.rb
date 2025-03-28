# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'switch_locale/:locale', to: 'welcome#switch_locale', as: :switch_locale
  get 'welcome/index'

  resources :guests, only: [:new] do
    collection do
      get "search"
      post "confirm"
    end
  end

  resources :guests do
    resources :plus_ones
    member do
      get :confirm
      patch :complete
    end
  end

  root 'welcome#index'

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
