BudgetApp::Application.routes.draw do
  resources :users, except: [:new]
  resources :sessions, only: [:new, :create, :destroy]
  resources :budgets, except: [:show, :edit]
  resources :expenses, except: [:new, :show]
  resources :incomes, except: [:new, :show]
  
  root 'sessions#new'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/signup', to: 'users#new', via: 'get'
  # Temporary, until i can design a cool home page
  #match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  #match '/users/:id/budget', to: 'budgets#new', via: 'get'
  
  # these dont work... not sure how to match, maybe get is being used?
  #match '/budget', to: 'budgets#show', via: 'get'
  #match '/budget/new', to: 'budgets#new', via: 'get'
  match '/budget', to: 'budgets#show', via: 'get', as: 'show_budget'
  match '/budget/edit', to: 'budgets#edit', via: 'get', as: 'edit_budget'
  match '/budget/expenses', to: 'expenses#show', via: 'get', as: 'show_expenses'
  match '/budget/expenses/new', to: 'expenses#new', via: 'get', as: 'new_expense'
  match '/budget/incomes/', to: 'incomes#show', via: 'get', as: 'show_incomes'
  match '/budget/incomes/new', to: 'incomes#new', via: 'get', as: 'new_income'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
