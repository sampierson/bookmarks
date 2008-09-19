require File.dirname(__FILE__) + '/../test_helper'

class WebpageTest < ActiveSupport::TestCase
    
  def test_we_can_create_webpage
    assert_difference 'Webpage.count' do
      w = Webpage.create(:url => "a_website")
    end
  end
  
  def test_we_can_retrieve_webpage
    w = Webpage.find_by_url('webpage_1')
    assert_not_nil w
  end
  
  def test_webpage_has_many_columns
    w = Webpage.find_by_url('webpage_1')
    assert_not_nil w
    assert_equal 2, w.columns.count
  end
  
end
