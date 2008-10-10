class Bookmark < ActiveRecord::Base
  belongs_to :section
  has_one :image
  validates_numericality_of :nth_from_top_of_section, :only_integer => true
  validates_presence_of :legend
  validate :section_must_exist
  
  # Generates a DOM ID we can use to manipulate this entity when it is in the HTML page.
  def dom_id
    "bookmark_#{id}"
  end
  
  def draggable_id
    "draggableBookmark_#{id}"
  end
  
  private
  
  def section_must_exist
    errors.add(:section_id, "must refer to an existing section") if section.nil?
  end
  
end
