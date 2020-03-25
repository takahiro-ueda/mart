Rails.application.routes.draw do
  get 'purchase/index'
  get 'purchase/done'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  root to: "home#index"
  # root to: "credit#new"

  
  resources :credit, only: [:new, :show] do
    collection do
      post 'show', to: 'credit#show'
      post 'pay', to: 'credit#pay'
      post 'delete', to: 'credit#delete'
    end
  end
end
