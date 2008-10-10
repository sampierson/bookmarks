class DeleteImageFromBookmark < ActiveRecord::Migration
  
  def self.up
    change_table :bookmarks do |t|
      t.remove :image
    end
  end

  def self.down
    change_table :bookmarks do |t|
      t.string :image
    end
  end
  
end
