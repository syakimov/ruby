Rails.application.routes.draw do
  # http://localhost:3000/welcome/index
  get 'welcome/index'

  root 'welcome#index'
end
