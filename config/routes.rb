Rails.application.routes.draw do
  resources :messages
  root "home#index"
end
