Rails.application.routes.draw do
  resources :transactions
  resources :wallets
  resources :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"public#homepage"

          devise_for :users, controllers: {
           
            registrations: 'user/registrations',
       
          }       
        
      
      
end
