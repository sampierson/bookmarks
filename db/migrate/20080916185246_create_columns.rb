class CreateColumns < ActiveRecord::Migration
  def self.up
    create_table :columns do |t|
      t.integer :webpage_id
      t.integer :nth_from_left

      t.timestamps
    end
  end

  def self.down
    drop_table :columns
  end
end
