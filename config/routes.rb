Rc::Application.routes.draw do
  devise_for :users

  root to: "welcome#index"
  resources :remote_controls
  get "/remote_controls/:id/open", to: "remote_controls#open", as: "remote_control_open"
  get "/remote_controls/:id/head_open", to: "remote_controls#head_open", as: "remote_control_head_open"
  
  resources :admin, only: [:index]
  get "/admin/notes", to: "admin#notes", as: "admin_notes"
  get "/admin/user_editor", to: "admin#user_editor", as: "admin_user_editor"
  get "/admin/user/:id/remove_admin/:q", to: "admin#remove_admin", as: "admin_remove_admin"
  get "/admin/user/:id/remove_controller/:q", to: "admin#remove_controller", as: "admin_remove_controller"
  get "/admin/user/:id/add_admin/:q", to: "admin#add_admin", as: "admin_add_admin"
  get "/admin/user/:id/add_controller/:q", to: "admin#add_controller", as: "admin_add_controller"
  get "/admin/access_control", to: "admin#access_control", as: "admin_access_control"
  get "/admin/access_control/disable/:id", to: "admin#access_control_disable", as: "admin_access_control_disable"
  get "/admin/access_control/enable/:id", to: "admin#access_control_enable", as: "admin_access_control_enable"
  
  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/admin/sidekiq', as: "sidekiq"
  end

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
