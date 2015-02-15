Rails.application.routes.draw do
  resources :books 
  get 'genres/:genre', to: 'books#index', as: :genre
  root to: 'books#index'

end
