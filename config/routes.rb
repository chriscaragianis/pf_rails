Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/new'

  get 'plan/new'

  get 'plan/create'

  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get "dashboard" => 'users#show'
  get "plotdata" => 'plans#run_plan'
  root 'welcome#index'
  get 'welcome/setup' => 'welcome#setup'
  get    'signup'  => 'users#new' 
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users
  get 'plans/index' => 'plans#index'
  post 'plans/create' => 'plans#create'
  resources :balance_records
  post '/balance_records/new' => 'plans#index'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
    get 'accounts/index' => 'accounts#index'
    get 'accounts/new' => 'accounts#new'
    post 'accounts/create' => 'accounts#create'
    delete 'accounts/delete/:id' => 'accounts#destroy'
    get 'accounts/update' => 'accounts#update'
    
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
