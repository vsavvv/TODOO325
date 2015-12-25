Rails.application.routes.draw do
  root to: 'tasks#index'
  
  resources :users do
    collection do
      get :sign_in
      post :authenticate
      put :exit
    end
    member do
      get :tasks
      get :join_task
      put :dock
      put :undock
    end
  end
  resources :tasks do
    member do
      get :users
      get :join_user
      put :dock
      put :undock
      put :complete
    end
  end
end
