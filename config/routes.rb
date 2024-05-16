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
  delete 'deck/:id' => 'decks#destroy'
  get 'decks-data' => 'decks#index'
  patch 'deck/:id' => 'decks#update'

  post 'cards' => 'cards#create'

  get 'up' => 'rails/health#show', as: :rails_health_check

  get '/*spa' => 'application#spa'
end
