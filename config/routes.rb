Rc::Application.routes.draw do
  devise_for :users

  root to: "welcome#index"
  resources :remote_controls
  get "/remote_controls/:id/open", to: "remote_controls#open", as: "remote_control_open"
  get "/remote_controls/:id/head_open", to: "remote_controls#head_open", as: "remote_control_head_open"

  resources :admin, only: [:index]
  get "/admin/notes", to: "admin#notes", as: "admin_notes"
  get "/admin/user_editor", to: "admin#user_editor", as: "admin_user_editor"
  get "/admin/user/:id/add_admin/:q", to: "admin#add_admin", as: "admin_add_admin"
  get "/admin/user/:id/remove_admin/:q", to: "admin#remove_admin", as: "admin_remove_admin"
  get "/admin/user/:id/add_controller/:q", to: "admin#add_controller", as: "admin_add_controller"
  get "/admin/user/:id/remove_controller/:q", to: "admin#remove_controller", as: "admin_remove_controller"
  get "/admin/stats", to: "admin#stats", as: "admin_stats"
  get "/admin/access_control", to: "admin#access_control", as: "admin_access_control"
  get "/admin/access_control/disable/:id", to: "admin#access_control_disable", as: "admin_access_control_disable"
  get "/admin/access_control/enable/:id", to: "admin#access_control_enable", as: "admin_access_control_enable"

  # namespace :user do
    resources :api_keys, only: [:create, :update, :destroy]
  # end

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/admin/sidekiq', as: "sidekiq"
  end

end
