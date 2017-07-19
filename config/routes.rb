Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
  	resources :profiles
  end
  resources :messages
  resources :articles, only: :edit

  root 'mains#index'

  get 'sign_in',  to: 'sessions#new',     as: :sign_in
  get 'sign_out', to: 'sessions#destroy', as: :sign_out
  post 'create',  to: 'sessions#create',  as: :sessions

  mount ActionCable.server => '/cable'
end
