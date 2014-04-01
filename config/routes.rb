TestApp::Application.routes.draw do
  #resources :rocket_actions

  get "/rocket_actions", to: "rocket_actions#index", as: "rocket_actions"
  get "/rocket_actions/new", to:"rocket_actions#new", as: "new_rocket_action"
  get "/rocket_actions/:id", to: "rocket_actions#show", as: "rocket_action"
  post "/rocket_actions", to: "rocket_actions#create"
  get "/employees/:employee_id/assoc", to:"employees#association_form", as: "associate_rocket_action_to_employee"
  post "/employees/:employee_id/assoc", to:"employees#associate_rocket_action_to_employee"

=begin
  get "/rocket_actions/:id/edit", to:"rocket_actions#edit", as: "edit_rocket_action"
  patch "/rocket_actions/:id", to:"rocket_actions#update"
  put "/rocket_actions/:id", to:"rocket_actions#update"
  delete "/rocket_actions/:id", to:"rocket_actions#destroy"
=end

  
  resources :employees

  root "application#index"
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
