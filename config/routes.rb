Rails.application.routes.draw do
  get 'password_resets/new'

  resources :users
  resources :password_resets
  resources :sessions, only: [:new, :create, :destroy]
  root  'static_pages#home'  
  match '/help',         to: 'static_pages#help',    via: 'get'
  match '/about',        to: 'static_pages#about',   via: 'get'
  match '/contact',      to: 'static_pages#contact', via: 'get'
  match '/signup',       to: 'users#new',            via: 'get'
  match '/signin',       to: 'sessions#new',         via: 'get'
  match '/signout',      to: 'sessions#destroy',     via: 'delete'
  match '/top10',        to: 'users#top10',          via: 'get'
  match '/remove_image', to: 'users#remove_image',   as: :remove_image, via: 'get'
  match '/password_resets/:id/edit', to: 'password_resets#update', via: 'patch'
  # get "remove_image" => "users#remove_image"
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
