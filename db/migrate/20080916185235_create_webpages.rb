class CreateWebpages < ActiveRecord::Migration
  
  def self.up
    create_table :webpages do |t|
      t.string :url, :null => false
      t.timestamps
    end
    add_index :webpages, :url
  end

  def self.down
    drop_table :webpages
  end
  
end
