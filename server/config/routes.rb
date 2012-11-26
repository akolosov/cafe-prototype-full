Cafe::Application.routes.draw do

  get 'main/index'

  root :to => 'main#index'

  match 'main/getgroupslist/:format' => 'main#getgroupslist'
  match 'main/getgroupslist/:locale/:format' => 'main#getgroupslist'

  match 'main/getcurrentmenuheaders/:format' => 'main#getcurrentmenuheaders'
  match 'main/getcurrentmenuheaders/:locale/:format' => 'main#getcurrentmenuheaders'
  match 'main/getcurrentorderheader/:format' => 'main#getcurrentorderheader'

  match 'main/getmenuitems/:menu_id/:format' => 'main#getmenuitems'
  match 'main/getmenuitems/:menu_id/locale/:locale/:format' => 'main#getmenuitems'
  match 'main/getcurrentmenuitems/:format' => 'main#getcurrentmenuitems'
  match 'main/getcurrentmenuitems/:locale/:format' => 'main#getcurrentmenuitems'

  match 'main/getmenuitem/:item_id/:format' => 'main#getmenuitem'
  match 'main/getmenuitem/:item_id/locale/:locale/:format' => 'main#getmenuitem'

  match 'main/getmenuitems/:menu_id/bygroup/:group_id/:format' => 'main#getmenuitemsbygroup'
  match 'main/getmenuitems/:menu_id/bygroup/:group_id/locale/:locale/:format' => 'main#getmenuitemsbygroup'
  match 'main/getcurrentmenuitemsbygroup/:group_id/:format' => 'main#getcurrentmenuitemsbygroup'
  match 'main/getcurrentmenuitemsbygroup/:group_id/locale/:locale/:format' => 'main#getcurrentmenuitemsbygroup'

  match 'main/getmenugroups/:menu_id/:format' => 'main#getmenugroups'
  match 'main/getmenugroups/:menu_id/locale/:locale/:format' => 'main#getmenugroups'
  match 'main/getcurentmenugroups/:format' => 'main#getcurrentmenugroups'
  match 'main/getcurrentmenugroups/:locale/:format' => 'main#getcurrentmenugroups'

  match 'main/getorderitems/:order_id/:format' => 'main#getorderitems'
  match 'main/getorderitems/:order_id/locale/:locale/:format' => 'main#getorderitems'

  match 'main/getordersumm/:order_id/:format' => 'main#getordersumm', :via => :post

  match 'main/putorderitem/:order_id/item/:item_id/count/:count/:format' => 'main#putorderitem'

  match 'main/checkorder/:order_id/:format' => 'main#checkorder', :via => :post

  match 'main/getuserinfo/:user_id/:format' => 'main#getuserinfo'

  match 'main/getcurrentuser/:format' => 'main#getcurrentuser'

  match 'main/getuseraccounts/:user_id/:format' => 'main#getuseraccounts'

  match 'main/userregister/:format' => 'main#userregister', :via => :post

  match 'main/userlogin/:format' => 'main#userlogin', :via => :post

  match 'main/userlogout/:format' => 'main#userlogout'

  match 'main/getcurrentsession/:format' => 'main#getcurrentsession'

  match 'main/getrandomcode/:format' => 'main#getrandomcode'
  match 'main/putuserbonus/:code/:format' => 'main#putuserbonus'

  resources :main do
  end

  resources :groups, :properties, :game_codes

  resources :menus do
    resources :items, :controller => 'menu_items'
  end

  match 'orders/:id/close' => 'orders#close', :as => :close_order
  match 'orders/:id/check' => 'orders#check', :as => :check_order

  resources :orders do
    resources :items, :controller => 'order_items'
  end

  resources :items do
    resources :properties, :controller => 'item_properties'
  end

  resources :user_sessions, :password_resets

  resources :users do
    resources :accounts, :controller => 'user_accounts'

    resources :properties, :controller => 'user_properties'

    member do
      get :activate
    end
  end

  match 'login' => 'user_sessions#new', :as => :login

  match 'logout' => 'user_sessions#destroy', :as => :logout

  match 'profile' => 'users#show', :as => :profile

  resource :oauth do
    get :callback
  end

  match 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider

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

  # You can have the root of your site routed with 'root'
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with 'rake routes'

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
