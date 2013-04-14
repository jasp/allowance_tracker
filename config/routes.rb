AllowanceTracker::Application.routes.draw do
  resources :expenses
  resources :allowances
  resources :accounts

  root :to => 'accounts#index'
end
