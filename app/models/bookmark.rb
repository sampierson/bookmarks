class Bookmark < ActiveRecord::Base
  belongs_to :section
  validates_numericality_of :nth_from_top_of_section
end
