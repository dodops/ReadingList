Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :books do
    collection do
      get 'search'
      get 'user_list'
    end
    member do
      post 'subscribe'
      delete 'unsubscribe'
    end
  end
  get 'genres/:genre', to: 'genres#show', as: :genre
  root to: 'books#index'

end
