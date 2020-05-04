Rails.application.routes.draw do
  resources :mails
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'users#index'

  resources :users do
    get 'mail_details'
    # post 'add_contact_to_group'
    collection do
       get 'search_group'
      # get 'search_group_contacts'
    end
  end

  # get 'users/mail_details'

  get 'users/connect_callback'
  get 'users/disconnect_callback'
  get 'users/login_callback'

  get 'auth/google/callback' , to: 'users#create'
end
