Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root to: 'toppages#index'
    
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    get 'signup', to: 'users#new'
    get 'member/:id', to: 'gyms#member', as: 'member'
    
    resources :users do
      member do
        get :joinings
      end
    end
    
    resources :posts, only: [:new, :create, :edit, :update, :destroy]
    resources :gyms
    resources :gym_users, only: [:create, :destroy]
    
end
