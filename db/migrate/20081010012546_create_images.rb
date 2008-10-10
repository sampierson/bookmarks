class CreateImages < ActiveRecord::Migration
  
  def self.up
    create_table :images do |t|
      t.integer :bookmark_id
      t.integer :size
      t.string :content_type
      t.string :filename
      t.integer :height
      t.integer :width
      t.integer :parent_id
      t.string :thumbnail
      t.timestamps
    end
    add_index :images, :bookmark_id
  end

  def self.down
    drop_table :images
  end
  
end
