Gitly::Application.routes.draw do

  resources :projects

  resources :subscriptions

  resources :categories

  get 'validate/:auth_token' => "users#validate"
  get 'unsubscribe/:auth_token' => "users#unsubscribe"
  get 'subscriptions/:auth_token/update' => "subscriptions#edit"
  post 'subscriptions/update' => 'subscriptions#update', :as => 'update_subscription'

  root 'subscriptions#new'
end
