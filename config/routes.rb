Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      resources :auth, only: [:create]
      resources :transactions
      post '/plaidlogin', to: 'plaid#plaidlogin'
      post '/get-transactions', to: 'plaid#getTransactions'
      get '/transactions', to: 'transactions#index'
      get '/budgets', to: 'budgets#index'
    end
  end

end
