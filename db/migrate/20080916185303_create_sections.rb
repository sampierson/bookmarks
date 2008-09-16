class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.integer :column_id
      t.integer :nth_section_from_top
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
