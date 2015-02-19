Rails.application.routes.draw do
  devise_for :users
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
  get ':genre', to: 'books#index', as: :genre
  root to: 'books#index'

end
