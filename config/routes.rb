Rails.application.routes.draw do
  resources 'employees'
  resources 'vacations'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "employess#index"
end
