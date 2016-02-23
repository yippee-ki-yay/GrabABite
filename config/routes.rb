Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :restaurants do
    collection do
      get 'managers_restaurant'
      get 'add_tables'
      get 'menu'
      post 'add_table'
      post 'add_item'
    end
  end
  
    
  
  resources :managers do
    collection do
      get 'index'
      get 'new'
    end
  end
  
    resources :home do
        collection do
            get 'friends'
            get 'profile'
            get 'visits'
            get 'invitations'
            get 'restaurants_reserve'
            post 'add_friend'
            post 'dump_friend'
            post 'decline_invite'
          post 'accept_invite'
        end
    end
    
  #  devise_for :users, :controllers => {:registrations => "registrations"}
    
    resources :reservation do
        collection do
            get 'friends_to_visit'
          get 'choose_table'
          post 'table_to_visit'
          post 'create'
          post 'invite_friend'
          get 'visit_done'
          post 'rate_visit'
          post 'is_reserved'
          post 'get_tables'
          post 'table_reserved'
        end
    end
    
  devise_scope :user do
  authenticated :user do
    root 'home#index', as: :authenticated_root
  end

  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
end
    
    post "restaurants/create"
    
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
    root 'restaurants#index'

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
