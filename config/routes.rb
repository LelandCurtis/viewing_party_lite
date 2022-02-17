Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/register', to: 'users#new'



  resources :users, only: [:index, :create] do
    get '/discover', to: 'users#discover'
    post '/movies', to: 'movies#index'
    resources :movies, only: [:index, :show] do
      get '/viewing-party/new', to: 'parties#new'
      post '/viewing-party/new', to: 'parties#create'
    end
  end

  get '/dashboard', to: 'users#show'



end
