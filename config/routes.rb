Rails.application.routes.draw do
  root to: "records#index"
  resources :records do
    collection do
      get 'whole' 
      get 'suitotyo' 
      get 'shiwaketyo' 
      get 'mototyo' 
      get 'trial' 
      get 'pl' 
      get 'bs' 
    end
  end
end
