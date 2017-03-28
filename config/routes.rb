Rails.application.routes.draw do
  get 'bookmarks/index'

  get 'auctions/index'

  get 'auctions/show'

  get 'auctions/new'

  get 'auctions/create'

  devise_for :users

  # this doesn't pass the user id
  # namespace :users do
  #   resources :bookmarks, only: [:index]
  # end

  resources :users, only: [] do
    resources :bookmarks, only: [:index]
  end

  # get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :auctions, shallow: true do
    resources :bids, only:[:create, :destroy]
    resources :bookmarks, only: [:create, :destroy]
  end

  get 'profile' => 'profile#index'
  patch 'profile' => 'profile#update'

end
