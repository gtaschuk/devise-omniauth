DeviseOmniauth::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :home
  root to: "home#index"
end
