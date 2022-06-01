Rails.application.routes.draw do
  post '/signup', to: 'users#create'
  post '/authenticate', to: 'authentication#authenticate'
  # delete '/signout', to: 'users#destroy'
end
