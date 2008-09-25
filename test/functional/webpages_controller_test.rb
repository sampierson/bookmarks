require File.dirname(__FILE__) + '/../test_helper'

class WebpagesControllerTest < ActionController::TestCase

  def setup
    @w = webpages(:page_1)
  end
  
  def test_routing
    assert_restful_routing("/admin/webpages", @w, { :controller => 'webpages' })
  end
  
  # Test REST CRUD actions
  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:webpages)
    assert_select 'div#canvas' do
      assert_select 'table#webpagesTable' do
        # Check for known webpages
        Webpage.all.each do |page|
          assert_select 'td.webpageUrl', page.url
          # Check for action links
          assert_select "td.rowAction a[href=#{webpage_path(page)}]", "Show"
          assert_select "td.rowAction a[href=#{edit_webpage_path(page)}]", "Edit"
          assert_select "td.rowAction a[href=#{webpage_path(page)}]", "Destroy"
        end
      end
    end
    assert_select "div#newWebpage a[href=#{new_webpage_path}]"
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
    assert_select 'div#canvas' do
      assert_select 'table#columnsTable' do
        # Check for known columns
        @w.columns.each do |column|
          assert_select 'td.columnNthFromLeft', "#{column.nth_from_left}"
          # Check for action links
          assert_select "td.rowAction a[href=#{webpage_column_path(@w,column)}]", "Show"
          assert_select "td.rowAction a[href=#{edit_webpage_column_path(@w,column)}]", "Edit"
          assert_select "td.rowAction a[href=#{webpage_column_path(@w,column)}]", "Destroy"
        end
      end
    end
    assert_select "td#newColumn a[href=#{new_webpage_column_path(@w)}]"
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
    assert_redirected_to webpages_path
  end
  
  def test_should_destroy_webpage
    assert_difference('Webpage.count', -1) do
      delete :destroy, :id => @w.id
    end
    assert_redirected_to webpages_path
  end
  
  # Test display and edit of webpage
  
  def test_display_page
    assert_routing({ :path => "/webpage_1", :method => :get },
                   { :controller => 'webpages', :action => 'display_page', :site => 'webpage_1' } )
    get :display_page, :site => 'webpage_1'
    assert assigns(:page)
    w = webpages(:page_1)
    assert_equal 'webpage_1', assigns(:page).url
    assert_select 'body #lane' do
      w.columns.each do |column|
        column.sections.each do |section|
          assert_select ".column .section .section_title", section.title
          section.bookmarks.each do |bookmark|
            assert_select ".column .section .bookmark a[href=#{bookmark.url}]", bookmark.legend
          end
        end
      end
    end
  end
  
end
