class Column < ActiveRecord::Base
  belongs_to :webpage
  has_many :sections
end
