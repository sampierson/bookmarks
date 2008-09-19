require File.dirname(__FILE__) + '/../test_helper'

class BookmarkTest < ActiveSupport::TestCase
  
 def test_cannot_create_bookmark_not_associated_with_a_section
   assert_no_difference 'Bookmark.count' do
     # To get a section id that we can be sure does not exist, delete one.
     section = sections(:two)
     section.destroy
     s = create_bookmark :section_id => section.id
     assert_errors_on(s, :section_id)
   end
 end
 
 def test_bookmark_rejects_non_integer_sequence_numbers
   section_id = sections(:one).id
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
     s = sections(:one).bookmarks.create(:nth_from_top_of_section => 3, :legend => nil)
     assert_errors_on(s, :legend)
   end
 end
 
 def test_can_create_valid_bookmark
   assert_difference 'Bookmark.count' do
     sections(:one).bookmarks.create(:nth_from_top_of_section => 3, :legend => "foo")
   end
 end

 def test_all_validation_simultaneously
   assert_no_difference 'Bookmark.count' do
     # To get a section id that we can be sure does not exist, delete one.
     section = sections(:two)
     section.destroy
     s = create_bookmark :section_id => section.id, :nth_from_top_of_section => "sdf", :legend => nil
     assert_errors_on(s, :section_id, :nth_from_top_of_section, :legend)
   end
 end
 
 def create_bookmark(options = {})
   record = Bookmark.new({ :section_id => sections(:one).id,
                           :nth_from_top_of_section => 3,
                           :legend => "this is a bookmark",
                           :url => nil,
                           :image => nil }.merge(options))
   record.save
   record
 end
 
end
