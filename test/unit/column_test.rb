require File.dirname(__FILE__) + '/../test_helper'

class ColumnTest < ActiveSupport::TestCase

  def test_cannot_create_column_not_associated_with_a_webpage
    # To get a webpage id that we can be sure does not exist, delete one.
    webpage = webpages(:page_2)
    webpage.destroy
    assert_no_difference 'Column.count' do
      c = Column.create(:webpage_id => webpage.id, :nth_from_left => 1)
      assert_errors_on(c, :webpage_id)
    end
  end
  
  def test_rejects_non_integer_column_numbers
    webpage_id = webpages(:page_1).id
    assert_no_difference 'Column.count' do
      c = Column.create(:webpage_id => webpage_id, :nth_from_left => "sdf")
      assert_errors_on(c, :nth_from_left)
    end
    assert_no_difference 'Column.count' do
      c = Column.create(:webpage_id => webpage_id, :nth_from_left => 3.14)
      assert_errors_on(c, :nth_from_left)
    end
  end
  
  def test_can_create_valid_column
    assert_difference 'Column.count' do
      webpages(:page_1).columns.create(:nth_from_left => 3)
    end
  end
  
end
