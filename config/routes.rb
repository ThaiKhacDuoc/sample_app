Rails.application.routes.draw do
  root "static_pages#home"
  get "demo_partials/new"
  get "demo_partials/edit"
  scope "(:locale)", locale: /en|vi/ do
    get "static_pages/home"
    get "/help", to: "static_pages#help"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :account_activations, only: :edit
    resources :password_resets, only: %i(new create edit update)
    resources :microposts, only: %i(create destroy)
  end
end
