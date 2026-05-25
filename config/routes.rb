Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }



  namespace :admin do
    resources :schools do
      # Create/list school_admins for a school
      resources :admins, only: [:create, :index]
      # List courses of a school
      get 'courses', to: 'schools#courses'
    end
  end

  namespace :school_admin do
    resource :school, only: [:show, :update]

    resources :courses do
      # List batches of a course
      resources :batches, only: [:index]
    end

    resources :batches do
      # Custom action: add student manually to batch
      post 'add_student', on: :member
      # List students in batch
      get 'students', on: :member
    end

    resources :enrollment_requests, only: [:index] do
      # Approve/Deny requests
      patch 'approve', on: :member
      patch 'deny', on: :member
    end
  end

  namespace :student do
    resources :enrollment_requests, only: [:create, :index, :destroy] do
      collection do
        get 'my', to: 'enrollment_requests#my_requests'
      end
    end

    resources :batches, only: [:index] do
      # View classmates in batch
      get 'students', on: :member
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
