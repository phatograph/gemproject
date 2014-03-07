Gemproject::Application.routes.draw do
  devise_for :users

  authenticated :user do
    namespace :api do
      resources :users
      resources :projects do
        get :by_requester_department, :on => :collection

        resources :tasks do
          get :detailed, :on => :member
        end
      end
      resources :memberships
      resources :assignments do
        post :start, :on => :member
        put :stop, :on => :member
        get :mine, :on => :collection
        delete :delete_all_timelogs, :on => :member
      end
      resources :timelogs
    end

    # Erb-rendered templates, without layouts.
    get '/templates/*id' => 'templates#show', :as => :template

    # Catch all for HTML5 History API and root path.
    get '*page' => 'high_voltage/pages#show', :id => 'index'
    root :to => 'high_voltage/pages#show', :id => 'index'
  end

  unauthenticated :user do
    devise_scope :user do
      get '/' => 'devise/sessions#new'
    end
  end
end
