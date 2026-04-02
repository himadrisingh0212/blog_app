Rails.application.routes.draw do
  root to: "home#index"   # unauthenticated root — also provides root_path everywhere
  # Devise routes for users with Google OAuth
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Friendly URL aliases
  devise_scope :user do
    get "/login",   to: "devise/sessions#new"
    get "/sign_up", to: "devise/registrations#new"
  end

  # Posts and nested comments
  resources :posts do
    resources :comments, only: [:create]
  end

  resources :users, only: [:index]

  # Root paths
  authenticated :user do
    root "posts#index", as: :authenticated_root
  end

  

  # Profile
  get "/profile",            to: "profiles#show"
  resources :profile_fields, only: [:create]
  resource  :profile,        only: [:show, :update]

end