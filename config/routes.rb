Rails.application.routes.draw do
  get 'pages/index'
  get 'sessions/new'
  get 'users/index'
  get 'users/new'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'users/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    # collection for plural, member for singular
    collection do
      get  '/search', to: 'users#search', as: "search", action: "search"
    end
    resources :friends    
  end
  
  get    '/sign_up' => 'users#new', as: "sign_up"  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/',        to: 'pages#index', as: "root"
end
