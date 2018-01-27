Rails.application.routes.draw do
  resources :contacts
  resources :feeds
  get 'sessions/new'

  resources :blogs do
    collection do
      post :confirm
    end
    resources :comments
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :favorites, only: [:create, :destroy]

  if Rails.env.development?
  mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
