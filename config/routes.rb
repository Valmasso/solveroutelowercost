Rails.application.routes.draw do
  resources :maps, only: [:index, :show, :update, :destroy] do
    member do
      post :create
      post :search
    end
  end
end
