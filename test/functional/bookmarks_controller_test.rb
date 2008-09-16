require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:bookmarks)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_bookmark
    assert_difference('Bookmark.count') do
      post :create, :bookmark => { }
    end

    assert_redirected_to bookmark_path(assigns(:bookmark))
  end

  def test_should_show_bookmark
    get :show, :id => bookmarks(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => bookmarks(:one).id
    assert_response :success
  end

  def test_should_update_bookmark
    put :update, :id => bookmarks(:one).id, :bookmark => { }
    assert_redirected_to bookmark_path(assigns(:bookmark))
  end

  def test_should_destroy_bookmark
    assert_difference('Bookmark.count', -1) do
      delete :destroy, :id => bookmarks(:one).id
    end

    assert_redirected_to bookmarks_path
  end
end
