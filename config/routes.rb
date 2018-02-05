DCIY::Application.routes.draw do
  resources :builds do
    collection do
      post :all
    end
  end

  resources :projects, :except => [:index] do
    resources :builds, :except => [:edit, :update]
  end

  root to: "builds#index"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
