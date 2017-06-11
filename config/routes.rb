Rails.application.routes.draw do

  root 'blog/home#index'
  get '/login/authorized', to:'blog/sessions#authorize'


  namespace :blog do

    root 'home#index'
    get '/bar', to:'home#bar'
    get '/login', to:'sessions#new',     as: :login
    post '/login', to:'sessions#create'

    resources :posts
    resources :users
    resources :cases

  end

  namespace :cpanel do

    root 'base#index'

    resources :posts
    resources :users
    resources :cases do
      collection do
        post :get_options
      end
    end

  end

end
