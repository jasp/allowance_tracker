AllowanceTracker::Application.routes.draw do
  resources :accounts, shallow: true do
    resources :allowances
  end

  resources :expenses

  root :to => 'accounts#index'
end
