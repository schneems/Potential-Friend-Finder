PotentialFriendFinder::Application.routes.draw do
  get "user_sessions/new"

  get "users/new"

  get "users/edit"
  
  root :to => "admins#show"
  match 'login' => 'admin_sessions#new'
  match 'logout' => 'admin_sessions#destroy'
  
  
  resources :admins do 
    resources :users
    get :seed
  end
  
  
  # if this was your app you def want to re-think what needs to be POST versus GET
  match ':user_1/create_arbitrary_friendship/:user_2' => 'friendships#create_arbitrary_friendship', :as => :create_arbitrary_friendship
  match ':user_1/destroy_arbitrary_friendship/:user_2' => 'friendships#destroy_arbitrary_friendship', :as => :destroy_arbitrary_friendship

    
  
  resources :admin_sessions
  
  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
