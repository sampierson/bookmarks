class Column < ActiveRecord::Base
  belongs_to :webpage
  has_many :sections, :order => :nth_section_from_top, :dependent => :destroy
  validates_numericality_of :nth_from_left
end
