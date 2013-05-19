Rails.application.routes.draw do
  namespace :opawesome do
    resources :sessions
    resources :tests
  end
end
