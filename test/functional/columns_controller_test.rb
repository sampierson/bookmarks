require File.dirname(__FILE__) + '/../test_helper'

class ColumnsControllerTest < ActionController::TestCase

  def setup
    @w = webpages(:page_1)
    @c = @w.columns.first
  end
  
  # Test REST CRUD scaffold actions
  def test_routing
    object = @c
    path_prefix = "/admin/webpages/#{@w.id}/columns"
    common_results =  { :controller => 'columns', :webpage_id => @w.id.to_s }
    assert_restful_routing(path_prefix, object, common_results, %w{ new create show edit update destroy })
  end
  
  # Index method is not implemented for columns. Check this.
  def test_no_index_method
    assert_raise(ActionController::RoutingError) do
      get :index
    end
  end
  
  def test_should_get_new
    get :new, :webpage_id => @w.id
    assert_response :success
    assert_select "#canvas form[action=/admin/webpages/#{@w.id}/columns][method=post]"
  end

  def test_should_create_column
    w = webpages(:page_1)
    assert_difference('Column.count') do
      post :create, :webpage_id => @w.id, :column => { :nth_from_left => 3 }
    end
    assert_redirected_to webpage_path(@w)
  end
  
  def test_should_show_column
    get :show, :webpage_id => @w.id, :id => @c.id
    assert_response :success
    assert_select 'div#canvas' do
      assert_select 'table#sectionsTable' do
        # Check for known sections
        @c.sections.each do |section|
          assert_select 'td.sectionNthSectionFromTop', "#{section.nth_section_from_top}"
          assert_select 'td.sectionTitle', "#{section.title}"
          # Check for action links
          assert_select "td.rowAction a[href=#{webpage_column_section_path(@w,@c,section)}]", "Show"
          assert_select "td.rowAction a[href=#{edit_webpage_column_section_path(@w,@c,section)}]", "Edit"
          assert_select "td.rowAction a[href=#{webpage_column_section_path(@w,@c,section)}]", "Destroy"
        end
      end
    end
    assert_select "td#newSection a[href=#{new_webpage_column_section_path(@w,@c)}]"
  end
  
  def test_should_get_edit
    get :edit, :webpage_id => @w.id, :id => @c.id
    assert_response :success
    assert_select "#canvas form[action=#{webpage_column_path(@w,@c)}][method=post]" do
      assert_select "input[type=hidden][name=_method][value=put]"
    end
  end

  def test_should_update_column
    put :update, :webpage_id => @w.id, :id => @c.id, :column => { :nth_from_left => 3 }
    assert_redirected_to webpage_path(@w)
  end

  def test_should_destroy_column
    assert_difference('Column.count', -1) do
      delete :destroy, :webpage_id => @w.id, :id => @c.id
    end
    assert_redirected_to webpage_path(@w)
  end

  # Test Ajax actions
  
  # Simulate a drag/drop of page_1_column_2_section_1 onto page_1_column_1, inbetween sections 1 and 2 of that column.
  def test_sort_sections
    droptarget = columns(:page_1_col_1)
    assert_routing({ :path => "/webpage_1/columns/#{droptarget.id}/sort", :method => :post },
                   { :controller => 'columns', :action => 'sort_sections', :site => 'webpage_1', :id => droptarget.id.to_s } )
    dragged_section = sections(:page_1_col_2_sec_1)
    new_section_order = [ sections(:page_1_col_1_sec_1).id, dragged_section.id, sections(:page_1_col_1_sec_2).id ]
    xhr :post, :sort_sections, :site => webpages(:page_1).url,
        :id => droptarget.id, droptarget.droptarget_id => new_section_order
    assert_response :success
    # Check the database got rearranged
    assert_equal Section.find(dragged_section.id).column, droptarget
    # Check for rjs commands
    assert_select_rjs :insert_html, :bottom, 'flash_container'
  end

  def test_insert_column_before
    column = columns(:page_1_col_2)
    assert_routing({ :path => "/webpage_1/columns/#{column.id}/before", :method => :post },
                   { :controller => 'columns', :action => 'insert_column_before', :site => 'webpage_1', :id => column.id.to_s } )
    xhr :post, :insert_column_before, :site => webpages(:page_1).url, :id => column.id
    assert_response :success
    assert assigns(:new_column)
    assert_select_rjs :insert_html, :before, "#{column.dom_id}_and_insert_button", :partial => 'column', :object => @new_column
  end

  def test_add_column_on_right
    assert_routing({ :path => "/webpage_1/columns/new", :method => :post },
                   { :controller => 'columns', :action => 'add_column_on_right', :site => 'webpage_1' } )
    xhr :post, :add_column_on_right, :site => webpages(:page_1).url
    assert_response :success
    assert assigns(:new_column)
    assert_select_rjs :insert_html, :before, 'add_column_on_right_button', :partial => 'column', :object => @new_column
  end

  def test_delete_column
    col_to_del = columns(:page_1_col_2)
    assert_routing({ :path => "/webpage_1/columns/#{col_to_del.id}", :method => :delete },
                   { :controller => 'columns', :action => 'delete_column', :site => 'webpage_1', :id => col_to_del.id.to_s } )
    xhr :post, :delete_column, :site => webpages(:page_1).url, :id => col_to_del
    assert_response :success
    column_and_insert_button_id = col_to_del.dom_id + '_and_insert_button'
    # Only Scriptaculous. Can't test with assert_select_rjs.
    assert_match /afterFinish:function\(\) \{ #{column_and_insert_button_id}\.remove\(\); \}/, @response.body
  end
  
end
