Rails.application.routes.draw do
  devise_for :users, skip: %i[registrations sessions passwords]
  devise_scope :user do
    post '/sign_up', to: 'registrations#create'
    post '/sign_in', to: 'sessions#create'
    delete '/sign_out', to: 'sessions#destroy'
  end
  # Defines the root path route ("/")
  root to: 'health#check'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :banks, only: [:index, :create, :show, :update, :destroy] do
        collection do
          get :total
        end
      end

      resources :providers, only: [:index, :create, :show, :update, :destroy] do
        collection do
          get 'total'
        end
      end
    end
  end
end
