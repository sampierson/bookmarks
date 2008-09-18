class Section < ActiveRecord::Base
  belongs_to :column
  has_many :bookmarks, :order => :nth_from_top_of_section, :dependent => :delete_all
  validates_numericality_of :nth_section_from_top
  
  def full_name
    "#{column.webpage.url} column #{column.nth_from_left} section #{nth_section_from_top}:#{title}"
  end
  
end
