Rails.application.routes.draw do

  namespace :admin do
    root :to =>"base#index"
    resources :users do 
      resources :permissions

      put "permissions", to: "permissions#set", as: "set_permissions"
    end
  end

  root "projects#index"

  get "/signin" => "sessions#new"

  post "/signin" => "sessions#create"

  delete "/signout" => "sessions#destroy"

  resources :projects do
    resources :tickets
  end

  resources :users
end
