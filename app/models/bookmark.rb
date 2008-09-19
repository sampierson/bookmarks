class Bookmark < ActiveRecord::Base
  belongs_to :section
  validates_numericality_of :nth_from_top_of_section, :only_integer => true
  validates_presence_of :legend
  validate :section_must_exist
  
  def section_must_exist
    errors.add(:section_id, "must refer to an existing section") if section.nil?
  end
  
end
