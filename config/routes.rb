
Rails.application.routes.draw do

  resources :groups
  resources :transactions
  resources :wallets
  resources :accounts
  resources :income, controller: "transactions", type: "income"
  resources :expense, controller: "transactions", type: "expense"
  resources :transfer, controller: "transactions", type: "transfer"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to:"public#homepage"

  devise_for :users, controllers: {
    registrations: 'user/registrations',
    invitations: 'user/invitations',
  }  
          # get      '*path'       => redirect('/404') 
end
