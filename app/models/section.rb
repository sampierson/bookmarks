class Section < ActiveRecord::Base
  belongs_to :column
  has_many :bookmarks, :order => :nth_from_top_of_section
  
end
