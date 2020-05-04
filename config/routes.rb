Rails.application.routes.draw do
  resources :mails
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'

  resources :users do
    get 'mail_details'
    get 'disconnect_callback'
    collection do
       get 'search_group'
    end
  end

  get 'users/connect_callback'
  get 'users/login_callback'
  get 'auth/google/callback' , to: 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '*path', to: redirect('/'), via: :all
end
