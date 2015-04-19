Rails.application.routes.draw do

  namespace :admin do
    root :to =>"base#index"
    resources :users do 
      resources :permissions

      put "permissions", to: "permissions#set", as: "set_permissions"
    end

    resources :states do
      get :make_default, on: :member
    end
  end

  root "projects#index"

  get "/signin" => "sessions#new"

  post "/signin" => "sessions#create"

  delete "/signout" => "sessions#destroy"

  resources :projects do
    resources :tickets do
      get :search, on: :collection

      post :watch, on: :member
    end
  end

  resources :tickets do
    resources :comments
    resources :tags do
      delete :remove, on: :member
    end
  end

  resources :users

  resources :files

  namespace :api do
    namespace :v1 do
      resources :projects do
        resources :tickets
      end
    end

    namespace :v2 do 
      resources :projects do
        resources :tickets
      end
    end
  end


  get "/auth/:provider/callback" => "sessions#create"
end
