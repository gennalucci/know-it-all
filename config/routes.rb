Rails.application.routes.draw do
  # get 'likes/create'
  # get 'likes/destroy'
  # get 'dashboards/index'
  # get 'dashboards/settings'
  # get 'dashboards/show'
  # get 'dashboards/likes'
  devise_for :users
  root to: 'dashboards#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/dashboards', to: 'dashboards#index', as: :dashboard
  get '/settings', to: 'dashboards#settings', as: :settings
  get 'dashboards/likes', to: "dashboards#likes", as: :user_likes
  get '/dashboards/:id', to: 'dashboards#show', as: :article_show
  get '/setup', to: 'dashboards#setup'
  post 'likes/:id', to: "likes#create", as: :like_article
  delete 'likes/:id', to: "likes#destroy", as: :unlike_article

  resources :user_tags, only: [ :new, :create, :destroy ]
  get '/user_tags/create', to: 'user_tags#create_tags'

end
