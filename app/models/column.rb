class Column < ActiveRecord::Base
  belongs_to :webpage
  has_many :sections, :order => :nth_section_from_top, :dependent => :destroy
  validates_numericality_of :nth_from_left, :only_integer => true
  #validates_associated :webpage   # Up to Rails 2.1.1 validates_associated does not work as expected.
  validate :webpage_must_exist
  
  # Generates a DOM ID we can use to manipulate this entity when it is in the HTML page.
  def dom_id
    "column_#{id}"
  end
  
  private
  
  def webpage_must_exist
    errors.add(:webpage_id, "must refer to an existing webpage") if webpage.nil?
  end
  
end
