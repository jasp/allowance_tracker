AllowanceTracker::Application.routes.draw do
  resources :accounts, shallow: true do
    resources :allowances
    resources :expenses
  end

  root :to => 'accounts#index'
end
