require File.dirname(__FILE__) + '/../test_helper'

class BookmarksControllerTest < ActionController::TestCase
  # Index method is not implemented for bookmarks.
  # Show method is not implemented for bookmarks.
  # SAM how to check this?
  
  def setup
    @w = webpages(:page_1)
    @c = @w.columns.first
    @s = @c.sections.first
    @b = @s.bookmarks.first
  end
  
  def test_routing
    object = @b
    path_prefix = "/admin/webpages/#{@w.id}/columns/#{@c.id}/sections/#{@s.id}/bookmarks"
    common_results =  { :controller => 'bookmarks', :webpage_id => @w.id.to_s,
                        :column_id => @c.id.to_s, :section_id => @s.id.to_s }
    assert_restful_routing(path_prefix, object, common_results, %w{ new create edit update destroy })
  end
  
  def test_should_get_new
    get :new, :webpage_id => @w.id, :column_id => @c.id, :section_id => @s.id
    assert_response :success
    assert_select "#canvas form[action=/admin/webpages/#{@w.id}/columns/#{@c.id}/sections/#{@s.id}/bookmarks][method=post]"
  end

  def test_should_create_section
    assert_difference('Bookmark.count') do
      post :create, :webpage_id => @w.id, :column_id => @c.id, :section_id => @s.id,
           :bookmark => { :nth_from_top_of_section => 3, :legend => "foo" }
    end
    assert_redirected_to webpage_column_section_path(@w, @c, @s)
  end

  def test_should_get_edit
    get :edit, :webpage_id => @w.id, :column_id => @c.id, :section_id => @s.id, :id => @b.id
    assert_response :success
    assert_select "#canvas form[action=#{webpage_column_section_bookmark_path(@w,@c,@s,@b)}][method=post]" do
      assert_select "input[type=hidden][name=_method][value=put]"
    end
  end

  def test_should_update_section
    put :update, :webpage_id => @w.id, :column_id => @c.id, :section_id => @s.id, :id => @b.id,
        :bookmark => { :nth_from_top_of_section => 3, :legend => "foo" }
    assert_redirected_to webpage_column_section_path(@w, @c, @s)
  end

  def test_should_destroy_section
    assert_difference('Bookmark.count', -1) do
      delete :destroy, :webpage_id => @w.id, :column_id => @c.id, :section_id => @s.id, :id => @b.id
    end
    assert_redirected_to webpage_column_section_path(@w, @c, @s)
  end

end
