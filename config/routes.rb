Rails.application.routes.draw do
  resources :feeds
  get 'sessions/new'

  resources :blogs do
    collection do
      post :confirm
      post :comment
    end
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :favorites, only: [:create, :destroy]

end
