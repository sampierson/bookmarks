class Webpage < ActiveRecord::Base
  has_many :columns, :order => :nth_from_left
end