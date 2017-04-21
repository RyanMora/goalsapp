Rails.application.routes.draw do

  resources :goals, only: [:show, :create, :destroy, :edit, :update]

  resources :users, only: [:index, :new, :show, :create, :destroy] do
    resources :goals, only: [:new]
  end

  resource :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
