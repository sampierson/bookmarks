class CreateBookmarks < ActiveRecord::Migration
  
  def self.up
    create_table :bookmarks do |t|
      t.integer :section_id, :null => false
      t.integer :nth_from_top_of_section, :null => false
      t.string :legend, :null => false
      t.string :url
      t.string :image
      t.timestamps
    end
    add_index :bookmarks, :section_id
  end

  def self.down
    drop_table :bookmarks
  end
  
end
