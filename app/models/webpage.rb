class Webpage < ActiveRecord::Base
  has_many :columns, :order => :nth_from_left, :dependent => :destroy
  has_many :sections, :through => :columns
  validates_presence_of :url
end
