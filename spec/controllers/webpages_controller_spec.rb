require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WebpagesController do

  def mock_webpage(stubs={})
    @mock_webpage ||= mock_model(Webpage, stubs)
  end
  
  describe "REST CRUD admin scaffold actions" do
  
    describe "responding to GET index" do

      it "should expose all webpages as @webpages" do
        debugger
        Webpage.should_receive(:find).with(:all).and_return([mock_webpage])
        get :index
        assigns[:webpages].should == [mock_webpage]
      end
    
    end

    describe "responding to GET show" do

      it "should expose the requested webpage as @webpage" do
        Webpage.should_receive(:find).with("37", { :include => :columns}).and_return(mock_webpage)
        get :show, :id => "37"
        assigns[:webpage].should equal(mock_webpage)
      end
    
    end

    describe "responding to GET new" do
  
      it "should expose a new webpage as @webpage" do
        Webpage.should_receive(:new).and_return(mock_webpage)
        get :new
        assigns[:webpage].should equal(mock_webpage)
      end

    end

    describe "responding to GET edit" do
  
      it "should expose the requested webpage as @webpage" do
        Webpage.should_receive(:find).with("37").and_return(mock_webpage)
        get :edit, :id => "37"
        assigns[:webpage].should equal(mock_webpage)
      end

    end

    describe "responding to POST create" do

      describe "with valid params" do
      
        it "should expose a newly created webpage as @webpage" do
          Webpage.should_receive(:new).with({'these' => 'params'}).and_return(mock_webpage(:save => true))
          post :create, :webpage => {:these => 'params'}
          assigns(:webpage).should equal(mock_webpage)
        end

        it "should redirect to the created webpage" do
          Webpage.stub!(:new).and_return(mock_webpage(:save => true))
          post :create, :webpage => {}
          response.should redirect_to(webpage_url(mock_webpage))
        end
      
      end
    
      describe "with invalid params" do

        it "should expose a newly created but unsaved webpage as @webpage" do
          Webpage.stub!(:new).with({'these' => 'params'}).and_return(mock_webpage(:save => false))
          post :create, :webpage => {:these => 'params'}
          assigns(:webpage).should equal(mock_webpage)
        end

        it "should re-render the 'new' template" do
          Webpage.stub!(:new).and_return(mock_webpage(:save => false))
          post :create, :webpage => {}
          response.should render_template('webpages/scaffold/new')
        end
      
      end
    
    end

    describe "responding to PUT udpate" do

      describe "with valid params" do

        it "should update the requested webpage" do
          Webpage.should_receive(:find).with("37").and_return(mock_webpage)
          mock_webpage.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :webpage => {:these => 'params'}
        end

        it "should expose the requested webpage as @webpage" do
          Webpage.stub!(:find).and_return(mock_webpage(:update_attributes => true))
          put :update, :id => "1"
          assigns(:webpage).should equal(mock_webpage)
        end

        it "should redirect to the webpage" do
          Webpage.stub!(:find).and_return(mock_webpage(:update_attributes => true))
          put :update, :id => "1"
          response.should redirect_to(webpages_path)
        end

      end
    
      describe "with invalid params" do

        it "should update the requested webpage" do
          Webpage.should_receive(:find).with("37").and_return(mock_webpage)
          mock_webpage.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :webpage => {:these => 'params'}
        end

        it "should expose the webpage as @webpage" do
          Webpage.stub!(:find).and_return(mock_webpage(:update_attributes => false))
          put :update, :id => "1"
          assigns(:webpage).should equal(mock_webpage)
        end

        it "should re-render the 'edit' template" do
          Webpage.stub!(:find).and_return(mock_webpage(:update_attributes => false))
          put :update, :id => "1"
          response.should render_template('webpages/scaffold/edit')
        end

      end

    end

    describe "responding to DELETE destroy" do

      it "should destroy the requested webpage" do
        Webpage.should_receive(:find).with("37").and_return(mock_webpage)
        mock_webpage.should_receive(:destroy)
        delete :destroy, :id => "37"
      end
  
      it "should redirect to the webpages list" do
        Webpage.stub!(:find).and_return(mock_webpage(:destroy => true))
        delete :destroy, :id => "1"
        response.should redirect_to(webpages_url)
      end

    end

  end
  
  describe "regular user actions" do
    
    describe "responding to GET display_page" do
      
      it "should render the requested page"
      
    end
    
  end
  
end
