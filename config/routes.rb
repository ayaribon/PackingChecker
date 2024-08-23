Rails.application.routes.draw do
  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root 'static_pages#top'
  resources :users, only: %i[new create]
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy' 
  get "/choose_template_or_create", to: "travel_plans#choose_template_or_create"

  resources :templates, only: [:index, :show] do
    member do
      post :create_travel_plan
    end
  end  

  resources :travel_plans, only: %i[index new create show edit destroy update choose_template_or_create] do
    resources :tasks
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
