class CreateBookmarks < ActiveRecord::Migration
  def self.up
    create_table :bookmarks do |t|
      t.integer :section_id
      t.integer :nth_from_top_of_section
      t.string :legend
      t.string :image

      t.timestamps
    end
  end

  def self.down
    drop_table :bookmarks
  end
end
