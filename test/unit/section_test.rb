require File.dirname(__FILE__) + '/../test_helper'

class SectionTest < ActiveSupport::TestCase
  
  def test_cannot_create_section_not_associated_with_a_column
    assert_no_difference 'Section.count' do
      # To get a column id that we can be sure does not exist, delete one.
      column = columns(:two)
      column.destroy
      s = Section.create(:column_id => column.id, :nth_section_from_top => 1)
      assert_errors_on(s, :column_id)
    end
  end
  
  def test_section_rejects_non_integer_section_numbers
    column_id = columns(:one).id
    assert_no_difference 'Section.count' do
      s = Section.create(:column_id => column_id, :nth_section_from_top => "sdf")
      assert_errors_on(s, :nth_section_from_top)
    end
    assert_no_difference 'Section.count' do
      s = Section.create(:column_id => column_id, :nth_section_from_top => 3.14)
      assert_errors_on(s, :nth_section_from_top)
    end
  end
  
  def test_can_create_valid_section
    assert_difference 'Section.count' do
      columns(:one).sections.create(:nth_section_from_top => 2)
    end
  end
  
end
