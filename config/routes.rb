Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create] do
    member do
      get :confirm_email
      get :home
    end

    resources :tags

    resources :prefab_stores
  end

  post '/signin', to: 'sessions#signin'
  get '/signout', to: 'sessions#signout'

  root "welcome#home"
end
