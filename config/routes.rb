ActionController::Routing::Routes.draw do |map|
  
  # Administrative interface (scaffold).
  map.resources :webpages, :path_prefix => '/admin' do |webpage|
    webpage.resources :columns do |column|
      column.resources :sections do |section|        
        section.resources :bookmarks
      end
    end
  end
  
  # Users' interface.
  map.with_options :requirements => { :site => /[^\/]*/ } do |route|
    route.display_page ':site/',     :conditions => { :method => :get }, :controller => 'webpages', :action => 'display_page'
    route.edit_page    ':site/edit', :conditions => { :method => :get }, :controller => 'webpages', :action => 'edit_page'
    # The Ajax routes
    route.insert_column_before ':site/columns/:id/before',      :conditions => { :method => :post   }, :controller => 'columns',   :action => 'insert_column_before'
    route.add_column_on_right  ':site/columns/new',             :conditions => { :method => :post   }, :controller => 'columns',   :action => 'add_column_on_right'
    route.delete_column        ':site/columns/:id',             :conditions => { :method => :delete }, :controller => 'columns',   :action => 'delete_column'
    route.sort_sections        ':site/columns/:id/sort',        :conditions => { :method => :post   }, :controller => 'columns',   :action => 'sort_sections'
    route.new_section          ':site/sections/:column_id/new', :conditions => { :method => :post   }, :controller => 'sections',  :action => 'new_section'
    route.set_section_title    ':site/sections/:id/title',      :conditions => { :method => :post   }, :controller => 'sections',  :action => 'set_title'
    route.sort_bookmarks       ':site/sections/:id/sort',       :conditions => { :method => :post   }, :controller => 'sections',  :action => 'sort_bookmarks'
    route.edit_bookmark        ':site/bookmark/:id/edit',       :conditions => { :method => :post   }, :controller => 'bookmarks', :action => 'edit_bookmark'
  end

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
