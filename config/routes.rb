Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'dashboards/index'
  get 'dashboards/settings'
  get 'dashboards/show'
  get 'dashboards/likes'
  devise_for :users
  root to: 'dashboard#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/dashboard', to: 'dashboard#index', as: :dashboard
  get '/settings', to: 'dashboard#settings', as: :settings
  get '/dashboard/:id', to: 'dashboard#show', as: :article_show
  post 'likes/:id', to: "likes#create", as: :like_article
  delete 'likes/:id', to: "likes#destroy", as: :unlike_article
  get 'dashboard/likes', to: "dashboard#likes", as: :user_likes
end
