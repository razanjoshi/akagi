Rails.application.routes.draw do

  get 'cases/new'

  get 'cases/edit'

  get 'password_resets/new'

  get 'password_resets/edit'

  root 'static_pages#home'
  get '/bar', to:'static_pages#bar'
  get '/contact', to:'static_pages#contact'
  get '/about', to:'static_pages#about'
  get '/signup', to:'users#new'
  post '/signup', to:'users#create'
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete 'logout', to:'sessions#destroy'
  get '/login/authorized', to:"users#authorize"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources:users do
      member do
          get :following,:followers
      end
  end
  resources:account_activations, only:[:edit]
  resources:password_resets, only:[:new,:create,:edit,:update]
  resources:microposts, only:[:create,:destroy,:edit,:update]
  resources:relationships, only:[:create,:destroy]
  resources:cases
end
