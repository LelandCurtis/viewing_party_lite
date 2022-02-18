Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/logout', to: 'users#destroy'
  get '/register', to: 'users#new'



  resources :users, only: [:index, :create]

  post '/movies', to: 'movies#index'
  get '/discover', to: 'users#discover'
  get '/dashboard', to: 'users#show'

  resources :movies, only: [:index, :show] do
    get '/viewing-party/new', to: 'parties#new'
    post '/viewing-party/new', to: 'parties#create'
  end





end
