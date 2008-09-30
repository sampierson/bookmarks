ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class Test::Unit::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def assert_not_valid(record)
      assert (not record.valid?), "#{record.class.name} was valid when it wasn't supposed to be"
  end
  
  # Assert this ActiveRecord model has errors on the listed attributes.
  def assert_errors_on(model, *attrs)
    attrs.each do |attr|
      assert model.errors.on(attr), "Expected error on attribute #{attr.to_s} but it was clean"
    end
  end
  
  # Test restful routing for a resource.
  # Arguments:
  #   path_prefix     String  common element of URL path e.g. /thingeys
  #   object                  An object of this resource type to use in the tests.
  #   common_results  Hash    Results that will be common, e.g. { :controller => 'thingeys' }
  #
  # Replaces this:
  # new
  # assert_routing({ :path => "/admin/webpages/#{w.id}/columns/new", :method => :get },
  #                { :controller => 'columns', :action => 'new', :webpage_id => w.id.to_s })
  # # create
  # assert_routing({ :path => "/admin/webpages/#{w.id}/columns", :method => :post },
  #                { :controller => 'columns', :action => 'create', :webpage_id => w.id.to_s })
  # # show
  # assert_routing({ :path => "/admin/webpages/#{w.id}/columns/#{c.id}", :method => :get },
  #                { :controller => 'columns', :action => 'show', :webpage_id => w.id.to_s, :id => c.id.to_s})
  # # edit
  # assert_routing({ :path => "/admin/webpages/#{w.id}/columns/#{c.id}/edit", :method => :get },
  #                { :controller => 'columns', :action => 'edit', :webpage_id => w.id.to_s, :id => c.id.to_s })
  # # update
  # assert_routing({ :path => "/admin/webpages/#{w.id}/columns/#{c.id}", :method => :put },
  #                { :controller => 'columns', :action => 'update', :webpage_id => w.id.to_s, :id => c.id.to_s })
  # # delete
  # assert_routing({ :path => "/admin/webpages/#{w.id}/columns/#{c.id}", :method => :delete },
  #                { :controller => 'columns', :action => 'destroy', :webpage_id => w.id.to_s, :id => c.id.to_s })
                 
  def assert_restful_routing(path_prefix, object, common_results, routes_to_test = nil)
    routes = {
      'index'   => { :verb => :get,    :path_suffix => "",                   :results => {} },
      'new'     => { :verb => :get,    :path_suffix => "/new",               :results => {} },
      'create'  => { :verb => :post,   :path_suffix => "",                   :results => {} },
      'show'    => { :verb => :get,    :path_suffix => "/#{object.id}",      :results => { :id => object.id.to_s } },
      'edit'    => { :verb => :get,    :path_suffix => "/#{object.id}/edit", :results => { :id => object.id.to_s } },
      'update'  => { :verb => :put,    :path_suffix => "/#{object.id}",      :results => { :id => object.id.to_s } },
      'destroy' => { :verb => :delete, :path_suffix => "/#{object.id}",      :results => { :id => object.id.to_s } },
    }
    routes_to_test = routes.keys if routes_to_test.nil?
    routes_to_test.each do |action|
      path = { :path => (path_prefix + routes[action][:path_suffix]), :method => routes[action][:verb] }
      options = { :action => action }.merge(common_results).merge(routes[action][:results])
      assert_routing(path, options)
    end
  end

  def random_string(length)
    chars = ('a'..'z').to_a + ('A'..'Z').to_a
    (0...size).collect { chars[Kernel.rand(chars.length)] }.join
  end
  
end
