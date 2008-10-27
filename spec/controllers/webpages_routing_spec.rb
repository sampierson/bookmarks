require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WebpagesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "webpages", :action => "index").should == "/admin/webpages"
    end
  
    it "should map #new" do
      route_for(:controller => "webpages", :action => "new").should == "/admin/webpages/new"
    end
  
    it "should map #show" do
      route_for(:controller => "webpages", :action => "show", :id => 1).should == "/admin/webpages/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "webpages", :action => "edit", :id => 1).should == "/admin/webpages/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "webpages", :action => "update", :id => 1).should == "/admin/webpages/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "webpages", :action => "destroy", :id => 1).should == "/admin/webpages/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/admin/webpages").should == {:controller => "webpages", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/admin/webpages/new").should == {:controller => "webpages", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/admin/webpages").should == {:controller => "webpages", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/admin/webpages/1").should == {:controller => "webpages", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/admin/webpages/1/edit").should == {:controller => "webpages", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/admin/webpages/1").should == {:controller => "webpages", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/admin/webpages/1").should == {:controller => "webpages", :action => "destroy", :id => "1"}
    end
  end
end
