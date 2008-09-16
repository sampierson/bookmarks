class Section < ActiveRecord::Base
  belongs_to :column
  has_many :bookmarks
end
