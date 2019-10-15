Rails.application.routes.draw do
  get 'mypage', to: 'users#show'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  root 'home#index'
  resources :users, only: %i[new create edit update]
  resources :articles
  resources :comments, only: %i[create destroy]
  resources :favorite_article_relations, only: %i[create destroy]
  resources :tags, only: %i[index new create edit update destroy]
end
