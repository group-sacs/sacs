Rails.application.routes.draw do

    devise_for :customers,skip: [:passwords], controllers: {
      registrations: "public/registrations",
    sessions: 'public/sessions'
    }
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
    }
    scope module: :public do
      root to: 'homes#top'
      get "/about" => "homes#about", as: "about"
      resources :delivery_addresses, only: [:index, :edit, :create, :update, :destroy]
      get 'orders/completion' => "orders#completion"
      post 'orders/confirm' => "orders#confirm"
      resources :orders, only: [:new, :index, :show, :create]
      resources :cart_items, only: [:index, :create, :destroy, :update]
      resources :cart_items, only: [:index, :create, :destroy, :update] do
      collection do
      delete :destroy_all
      end
  end
      delete "cart_items/destroy_all" => "cart_items#destroy_all"
      get "current_customer" => "customers#show"
      patch "current_customer" => "customers#update"
      get "current_customer/edit" => "customers#edit"
      get "current_customer/confirm" => "customers#confirm"
      patch "current_customer/withdraw" => "customers#withdraw"
      resources :items, only: [:index, :show]
    end
    
    namespace :admin do
      root to: 'homes#top'
      resources :orders, only: [:show, :update]
      resources :customers, only: [:index, :show, :edit, :update]
      resources :genres, only: [:index, :edit, :create, :update]
      resources :items, only: [:index, :new, :show, :edit, :create, :update]
      resources :order_details, only: [:update]
    end

  # namespace :admin do
  #   get 'customers/index'
  #   get 'customers/show'
  #   get 'customers/edit'
  # end
  # namespace :admin do
  #   get 'genres/index'
  #   get 'genres/edit'
  # end
  # namespace :admin do
  #   get 'items/index'
  #   get 'items/new'
  #   get 'items/show'
  #   get 'items/edit'
  # end
  # namespace :admin do
  #   get 'homes/top'
  # end
  # namespace :public do

  #   # get 'delivery/index'
  #   # get 'delivery/edit'
  # end
  # namespace :public do
  #   get 'orders/new'

  #   get 'orders/index'
  #   get 'orders/show'
  # end
  # namespace :public do
  #   get 'cart_items/index'
  # end
  # namespace :public do
  #   get 'customers/show'
  #   get 'customers/edit'

  # end
  # namespace :public do
  #   get 'items/index'
  #   get 'items/show'
  # end
  # namespace :public do
  #   get 'homes/top'
  #   get 'homes/about'
  # end

  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
