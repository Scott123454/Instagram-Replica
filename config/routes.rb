Rails.application.routes.draw do

  get 'comments/new'

  resources :posts do
    resources :comments
    resources :likes
  end

  resources :tags

  devise_for :users
  root 'posts#index'

end
