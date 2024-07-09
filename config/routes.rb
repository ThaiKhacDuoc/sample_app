Rails.application.routes.draw do
  root "static_pages#home"
  get "demo_partials/new"
  get "demo_partials/edit"
  scope "(:locale)", locale: /en|vi/ do
    get "static_pages/home"
    get "static_pages/help"
  end

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: :show
end
