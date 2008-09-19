class CreateColumns < ActiveRecord::Migration
  def self.up
    create_table :columns do |t|
      t.integer :webpage_id, :null => false
      t.integer :nth_from_left, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :columns
  end
end
