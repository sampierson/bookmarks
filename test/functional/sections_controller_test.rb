require File.dirname(__FILE__) + '/../test_helper'

class SectionsControllerTest < ActionController::TestCase

  # Index method is not implemented for sections.
  # SAM how to check this?
  
  def setup
    @w = webpages(:page_1)
    @c = @w.columns.first
    @s = @c.sections.first
  end
  
  def test_routing
    object = @s
    path_prefix = "/admin/webpages/#{@w.id}/columns/#{@c.id}/sections"
    common_results =  { :controller => 'sections', :webpage_id => @w.id.to_s, :column_id => @c.id.to_s }
    assert_restful_routing(path_prefix, object, common_results, %w{ new create show edit update destroy })
  end
  
  def test_should_get_new
    get :new, :webpage_id => @w.id, :column_id => @c.id
    assert_response :success
    assert_select "#canvas form[action=/admin/webpages/#{@w.id}/columns/#{@c.id}/sections][method=post]"
  end

  def test_should_create_section
    assert_difference('Section.count') do
      post :create, :webpage_id => @w.id, :column_id => @c.id,
           :section => { :nth_section_from_top => 3, :title => "foo" }
    end
    assert_redirected_to webpage_column_path(@w, @c)
  end
  
  def test_should_show_section
    get :show, :webpage_id => @w.id, :column_id => @c.id, :id => @s.id
    assert_response :success
    assert_select 'div#canvas' do
      assert_select 'table#bookmarksTable' do
        # Check for known bookmarks
        @s.bookmarks.each do |bookmark|
          assert_select 'td.bookmarkNthFromTopOfSection', bookmark.nth_from_top_of_section.to_s
          assert_select 'td.bookmarkLegend', bookmark.legend
          assert_select 'td.bookmarkUrl', bookmark.url.to_s
          assert_select 'td.bookmarkImage', bookmark.image.to_s
          # Check for action links
          assert_select "td.rowAction a[href=#{edit_webpage_column_section_bookmark_path(@w,@c,@s,bookmark)}]", "Edit"
          assert_select "td.rowAction a[href=#{webpage_column_section_bookmark_path(@w,@c,@s,bookmark)}]", "Destroy"
        end
      end
    end
    assert_select "td#newBookmark a[href=#{new_webpage_column_section_bookmark_path(@w,@c,@s)}]"
  end
  
  def test_should_get_edit
    get :edit, :webpage_id => @w.id, :column_id => @c.id, :id => @s.id
    assert_response :success
    assert_select "#canvas form[action=#{webpage_column_section_path(@w,@c,@s)}][method=post]" do
      assert_select "input[type=hidden][name=_method][value=put]"
    end
  end

  def test_should_update_section
    put :update, :webpage_id => @w.id, :column_id => @c.id, :id => @s.id,
        :section => { :nth_section_from_top => 3, :title => "foo" }
    assert_redirected_to webpage_column_path(@w, @c)
  end

  def test_should_destroy_section
    assert_difference('Section.count', -1) do
      delete :destroy, :webpage_id => @w.id, :column_id => @c.id, :id => @s.id
    end
    assert_redirected_to webpage_column_path(@w, @c)
  end

end
