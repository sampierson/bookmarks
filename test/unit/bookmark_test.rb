require File.dirname(__FILE__) + '/../test_helper'

class BookmarkTest < ActiveSupport::TestCase
  
 def test_cannot_create_bookmark_not_associated_with_a_section
   # To get a section id that we can be sure does not exist, delete one.
   section = sections(:page_2_col_1_sec_1)
   section.destroy
   assert_no_difference 'Bookmark.count' do
     s = create_bookmark :section_id => section.id
     assert_errors_on(s, :section_id)
   end
 end
 
 def test_bookmark_rejects_non_integer_sequence_numbers
   section_id = sections(:page_2_col_1_sec_1).id
   assert_no_difference 'Bookmark.count' do
     b = create_bookmark :section_id => section_id, :nth_from_top_of_section => "sdf"
     assert_errors_on(b, :nth_from_top_of_section)
   end
   assert_no_difference 'Bookmark.count' do
     b = create_bookmark :section_id => section_id, :nth_from_top_of_section => 3.14
     assert_errors_on(b, :nth_from_top_of_section)
   end
 end
 
 def test_cannot_save_without_legend
   assert_no_difference 'Bookmark.count' do
     s = sections(:page_2_col_1_sec_1).bookmarks.create(:nth_from_top_of_section => 2, :legend => nil)
     assert_errors_on(s, :legend)
   end
 end
 
 def test_can_create_valid_bookmark
   assert_difference 'Bookmark.count' do
     sections(:page_2_col_1_sec_1).bookmarks.create(:nth_from_top_of_section => 2, :legend => "foo")
   end
 end

 def test_all_validation_simultaneously
   # To get a section id that we can be sure does not exist, delete one.
   section = sections(:page_2_col_1_sec_1)
   section.destroy
   assert_no_difference 'Bookmark.count' do
     s = create_bookmark :section_id => section.id, :nth_from_top_of_section => "sdf", :legend => nil
     assert_errors_on(s, :section_id, :nth_from_top_of_section, :legend)
   end
 end
 
 def create_bookmark(options = {})
   record = Bookmark.new({ :section_id => sections(:page_2_col_1_sec_1).id,
                           :nth_from_top_of_section => 2,
                           :legend => "this is a bookmark",
                           :url => nil,
                           :image => nil }.merge(options))
   record.save
   record
 end
 
end
