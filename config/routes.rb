Rails.application.routes.draw do
  resources :members
  resources :match_results
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "members#index"
end
