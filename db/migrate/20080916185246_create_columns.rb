class CreateColumns < ActiveRecord::Migration

  def self.up
    create_table :columns do |t|
      t.integer :webpage_id, :null => false
      t.integer :nth_from_left, :null => false
      t.timestamps
    end
    add_index :columns, :webpage_id
  end

  def self.down
    drop_table :columns
  end
  
end
