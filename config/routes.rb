Rails.application.routes.draw do

  root 'blog/home#index'
  get '/login/authorized', to:'blog/sessions#authorize'


  namespace :api do
    namespace :v1 do
      resources :posts do
        collection do
          post :add_note
          get :get_note
          get :check_note
        end

      end
    end
  end

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

  namespace :wechat do

    root 'home#index'

    resources :posts
    resources :users
    resources :cases
    resources :photos


  end

end
