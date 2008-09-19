require File.dirname(__FILE__) + '/../test_helper'

class WebpagesControllerTest < ActionController::TestCase

  def setup
    @w = webpages(:page_1)
  end
  
  def test_routing
    assert_restful_routing("/admin/webpages", @w, { :controller => 'webpages' })
  end
   
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:webpages)
    assert_select 'div#canvas table#webpagesTable' do
      assert_select 'tr td.webpageUrl', "webpage_1"
      assert_select 'tr td.webpageUrl', "webpage_2"
      # TBD check for action links here too.
    end
    assert_select 'div#newWebpage'
  end
  
  def test_should_get_new
    get :new
    assert_response :success
    assert_select "#canvas form#new_webpage[action=#{webpages_path}][method=post]"
  end
  
  def test_should_create_webpage
    assert_difference('Webpage.count') do
      post :create, :webpage => { :url => "foo" }
    end
    assert_redirected_to webpage_path(assigns(:webpage))
  end
  
  def test_should_show_webpage
    get :show, :id => @w.id
    assert_response :success
    # SAM look for known columns
    # SAM look for "New Column" link
  end
  
  def test_should_get_edit
    get :edit, :id => @w.id
    assert_response :success
    assert_select "#canvas form#edit_webpage_#{@w.id}[action=#{webpage_path(@w)}][method=post]" do
      assert_select "input[type=hidden][name=_method][value=put]"
    end
  end
  
  def test_should_update_webpage
    put :update, :id => @w.id, :webpage => { :url => "foo" }
    assert_redirected_to webpage_path(@w)
  end
  
  def test_should_destroy_webpage
    assert_difference('Webpage.count', -1) do
      delete :destroy, :id => @w.id
    end
    assert_redirected_to webpages_path
  end
  
end
