Rails.application.routes.draw do
  resources :users, only: [:show, :create]
  resources :contacts

  post 'user_token' => 'user_token#create'
end
