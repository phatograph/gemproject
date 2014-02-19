Gemproject::Application.routes.draw do
  devise_for :users

  namespace :api do
    resources :users
  end

  # Erb-rendered templates, without layouts.
  get '/templates/*id' => 'templates#show', :as => :template

  # Catch all for HTML5 History API and root path.
  get '*page' => 'high_voltage/pages#show', :id => 'index'
  root :to => 'high_voltage/pages#show', :id => 'index'
end
