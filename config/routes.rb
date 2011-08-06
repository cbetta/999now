Helpmenow::Application.routes.draw do
  mount SecureResqueServer.new, :at => "/resque"
  
  get "frontpage/index"

  resources :alarms

  resources :authorisations
  
  root :to => 'frontpage#index'
end
