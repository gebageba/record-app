Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root to: 'records#index'
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
end
