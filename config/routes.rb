Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
    confirmations: 'users/confirmations'}, path_names: { sign_in: 'login', sign_out: 'logout'}
  
  authenticated :user do
    resources :contacts do
      collection do
        get 'search'
      end
      resources :addresses
    end
    resources :fund_transfers
    
  end
  root to: 'admins#index'
  
  
  resources :admins, only: [:index]
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end
