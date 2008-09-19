class CreateSections < ActiveRecord::Migration
  
  def self.up
    create_table :sections do |t|
      t.integer :column_id, :null => false
      t.integer :nth_section_from_top, :null => false
      t.string :title, :null => false
      t.timestamps
    end
    add_index :sections, :column_id
  end

  def self.down
    drop_table :sections
  end
  
end
