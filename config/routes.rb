Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create] do
    member do
      get :confirm_email
    end

    resources :tags
    
    resources :prefab_stores, only: [:index]
  end

  post '/signin', to: 'sessions#signin'
  post '/signout', to: 'sessions#signout'

  root "welcome#home"
end
