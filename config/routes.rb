Rails.application.routes.draw do
  post '/signup', to: 'users#create'
  # delete '/signout', to: 'users#destroy'
end
