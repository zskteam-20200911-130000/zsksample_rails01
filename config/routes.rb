Rails.application.routes.draw do
  root to: 'application#hello'

  resources :users
end
