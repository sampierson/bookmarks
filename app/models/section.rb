class Section < ActiveRecord::Base
  belongs_to :column
  has_many :bookmarks, :order => :nth_from_top_of_section, :dependent => :delete_all
  validates_numericality_of :nth_section_from_top, :only_integer => true
  validate :column_must_exist
  
  def column_must_exist
    errors.add(:column_id, "must refer to an existing column") if column.nil?
  end
  
  def full_name
    "#{column.webpage.url} column #{column.nth_from_left} section #{nth_section_from_top}:#{title}"
  end
  
end
