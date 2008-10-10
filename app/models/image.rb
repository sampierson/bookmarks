class Image < ActiveRecord::Base
  
  belongs_to :bookmark
  
  has_attachment  :storage => :file_system, 
                  :max_size => 1.megabytes,
                  :processor => :Rmagick # attachment_fu looks in this order: ImageScience, Rmagick, MiniMagick

  validates_as_attachment
  
end
