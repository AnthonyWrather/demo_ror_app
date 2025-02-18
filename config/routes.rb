Rails.application.routes.draw do
  resources :organisation_users
  # get "organisation_users/index"
  get "/calendar", to: "calendar#index"
  mount GoodJob::Engine => "good_job"
  resources :notifications, only: [ "index" ]
  get "/read_notifications", to: "read_notifications#read_all"
  get "/search", to: "search#index"
  # Defines the root path route ("/")
  # root "posts#index"
  devise_for :users
  resources :dashboard, only: [ :index ]
  resources :projects do
    resources :tasks
  end
  root "home#index"

  # get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
