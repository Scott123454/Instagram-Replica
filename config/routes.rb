Rails.application.routes.draw do

  devise_for :admins
  get 'comments/new'

  resources :posts do
    resources :comments
    resources :likes
    resources :charges
  end

  resources :tags
  resources :orders

  devise_for :users
  root 'posts#index'

end
