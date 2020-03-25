Rails.application.routes.draw do
  get 'purchase/index'
  get 'purchase/done'
  get 'credit/new'
  get 'credit/show'
  # devise_for :users, controllers: {
  #   registrations: 'users/registrations'
  # }
  # devise_scope :user do
  #   get 'addresses', to: 'users/registrations#new_address'
  #   post 'addresses', to: 'users/registrations#create_address'
  # end
  # root to: "home#index"
  root to: "credit#new"

  
  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end
end
