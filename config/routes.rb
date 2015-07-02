Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :products do
      resources :sale_prices, only: [:index, :create, :destroy]
    end
  end

  get '/sale',        to: 'home#sale', as: :sale
  get '/sale/t/*id/', to: 'home#sale', as: :sale_taxon
end
