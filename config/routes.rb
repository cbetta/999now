Helpmenow::Application.routes.draw do

  mount SecureResqueServer.new, :at => "/resque"
  
  get "frontpage/index"
  
  match "/notifications" => "notifications#index", :via => :post

  resources :alarms

  resources :authorisations
  
  root :to => 'frontpage#index'
end
