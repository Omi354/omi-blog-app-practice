Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "articles#index"
  resources :articles do
    resources :comments, only: [ :new, :create, :destroy ]
    resource :likes, only: [:create, :destroy]
  end

  get 'liked_articles', to: 'articles#liked_articles'
  resource :profile, only: [ :show, :edit, :update ]
end
