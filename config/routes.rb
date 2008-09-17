ActionController::Routing::Routes.draw do |map|
  
  # Administrative interface uses full scaffold.
  map.resources :webpages, :path_prefix => '/admin' do |webpage|
    webpage.resources :columns do |column|
      column.resources :sections do |section|
        section.resources :bookmarks
      end
    end
  end
  
  # Regular interface
  
  # These are the routes generated by "map.resources :webpages" with an added :site component/requirement.
  #with_options
  #map.webpages       ':site/webpages',         :requirements => { :site => /[^\/]*/ }, :conditions => { :method => :get },    :controller => 'webpages', :action => 'index'
  #map.new_webpage    ':site/webpage/new',      :requirements => { :site => /[^\/]*/ }, :conditions => { :method => :get },    :controller => 'webpages', :action => 'new'
  #map.create_webpage ':site/webpages',         :requirements => { :site => /[^\/]*/ }, :conditions => { :method => :post },   :controller => 'webpages', :action => 'create'
  #map.webpage        ':site/webpage/:id',      :requirements => { :site => /[^\/]*/ }, :conditions => { :method => :get },    :controller => 'webpages', :action => 'show'
  #map.edit_webpage   ':site/webpage/:id/edit', :requirements => { :site => /[^\/]*/ }, :conditions => { :method => :get },    :controller => 'webpages', :action => 'edit'
  #map.update_webpage ':site/webpage/:id',      :requirements => { :site => /[^\/]*/ }, :conditions => { :method => :put },    :controller => 'webpages', :action => 'update'
  #map.delete_webpage ':site/webpage/:id',      :requirements => { :site => /[^\/]*/ }, :conditions => { :method => :delete }, :controller => 'webpages', :action => 'destroy'
  # Now we add an additional route to just display the web page

  #map.resources :columns
  #
  #map.resources :sections
  #
  #map.resources :bookmarks
  #
  #map.display_webpage ':site/', :requirements => { :site => /[^\/]*/ }, :conditions => { :method => :get },    :controller => 'webpages', :action => 'display_page'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end