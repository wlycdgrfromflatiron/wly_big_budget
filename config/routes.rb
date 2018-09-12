Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create] do
    member do
      get :confirm_email
      get :home
    end

    resources :carts
    # add nested cart_items and cart_stores resources 
    resources :tags
    resources :prefab_stores
    resources :prefab_items
  end

  resources :carts do
    resources :cart_items, only: [:new, :create, :destroy]
  end

  get '/users/:user_id/carts/:id/additem', to: 'carts#additem'

  post '/signin', to: 'sessions#signin'
  get '/signout', to: 'sessions#signout'

  root "welcome#home"
end
