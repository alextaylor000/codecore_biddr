Rails.application.routes.draw do
  root "auctions#index"
  resources :auctions do
    resources :bids, only: [:create]
  end
end
