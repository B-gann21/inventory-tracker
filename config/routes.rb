Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'landing#index'
  
  # registering a user
  get '/users/new', to: 'users#new' 
  post '/users', to: 'users#create'
  
  # logging in and out
  get '/sessions/new', to: 'sessions#new'
  post '/sessions', to: 'sessions#create'
  delete '/sessions', to: 'sessions#destroy'

  # viewing, updating,and  deleting items
  get '/items', to: 'user_items#index' 
end
