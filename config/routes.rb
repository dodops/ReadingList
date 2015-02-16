Rails.application.routes.draw do
  resources :books do
    collection do
      get 'search'
    end
  end
  get ':genre', to: 'books#index', as: :genre
  root to: 'books#index'

end
