# frozen_string_literal: true

Rails.application.routes.draw do
  resources :elections do
    resources :audits, shallow: true, only: [:index], controller: 'election_audits'
    resources :questions, shallow: true do
      resources :answers, shallow: true
    end
    resources :voters, shallow: true do
      get :ballot, on: :member
      post :submit, on: :member
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
