Rails.application.routes.draw do
  # http://localhost:3000/welcome/index
  get 'welcome/index'

  resources :articles

  root 'welcome#index'
end
