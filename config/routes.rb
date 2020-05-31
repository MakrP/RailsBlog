Rails.application.routes.draw do
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  root 'articles#index'

  get 'about' => 'pages#about'

  get 'signup' => 'users#new'

  get 'edit' => 'users#edit'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'


  resources :articles do
    resources :comments
  end
  # resources :users
  resources :users, except: [:new]

end
