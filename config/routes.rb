Rails.application.routes.draw do
  root to: 'misc#hello'

  resources :users
end
