Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      get 'scratch_cards/scratch'

      resources :users , only: [:create] do
        get 'profile', on: :collection
      end
      
      resources :bank_accounts, only: [:create] do
        post 'primarize', on: :member
      end

      resources :transactions, only: [:create]

      resources :tokens, only: [] do
        post 'authenticate' , on: :collection
      end

      resources :scratch_cards, only: [] do
        post 'scratch', on: :member
      end

    end
  end
end
