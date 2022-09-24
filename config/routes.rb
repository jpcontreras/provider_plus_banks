Rails.application.routes.draw do
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
