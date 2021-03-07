# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :records do
    collection do
      get 'expence'
      get 'shiwaketyo'
      get 'mototyo'
      get 'trial'
      get 'pl'
      get 'bs'
    end
  end
  root to: 'records#welcome'
  get 'records/welcome' => 'records#welcome'
end
