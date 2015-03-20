Rails.application.routes.draw do

  namespace :admin do
    root :to =>"base#index"
    resources :users
  end

  root "projects#index"

  get "/signin" => "sessions#new"

  post "/signin" => "sessions#create"

  resources :projects do
    resources :tickets
  end

  resources :users
end
