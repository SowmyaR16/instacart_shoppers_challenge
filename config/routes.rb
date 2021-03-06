Rails.application.routes.draw do
  root "home#index"

  get 'shopper/sign_up' => 'applicants#new', as: :register

  get 'shopper/login' => 'sessions#new', as: :login
  post 'shopper/login' => 'sessions#create'
  get 'shopper/logout' => 'sessions#logout', as: :logout

  resources :applicants, only: [:create, :update, :edit, :new], path: "shoppers" do
    collection do
      get :background
      post :authorize, path: "authorize"
      get :confirm
    end
  end
  resources :funnels, only: [:index]
end
