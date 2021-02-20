# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
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
