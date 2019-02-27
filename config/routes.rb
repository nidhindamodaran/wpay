Rails.application.routes.draw do
  get 'tokens/authenticate'
  namespace :api do
    namespace :v1 do

      resources :users , only: [:create] do
        get 'profile', on: :collection
      end
      
      resources :bank_accounts do
        resources :transactions
      end
      resources :tokens, only: [] do
        post 'authenticate' , on: :collection
      end

    end
  end
end