Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :products, only: [] do
      resources :sale_prices
    end
  end

  get '/sale', to: 'home#sale', as: :sale
end