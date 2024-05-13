Rails.application.routes.draw do
  root 'application#index'
  devise_for :users, skip: :all
  devise_scope :user do
    get 'sign-in', to: 'devise/sessions#new'
    get 'sign-up', to: 'devise/registrations#new'
    post 'sign-in', to: 'devise/sessions#create'
    post 'sign-up', to: 'devise/registrations#create'
    delete 'sign-out', to: 'devise/sessions#destroy'
  end

  post 'decks' => 'decks#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get '/*all' => 'decks#index'
end
