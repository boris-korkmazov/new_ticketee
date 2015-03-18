Rails.application.routes.draw do

  root "projects#index"

  get "/signin" => "sessions#new"

  post "/signin" => "sessions#create"

  resources :projects do
    resources :tickets
  end

  resources :users
end
