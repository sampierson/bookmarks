class CreateWebpages < ActiveRecord::Migration
  
  validates_presence_of :url
  
  def self.up
    create_table :webpages do |t|
      t.string :url, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :webpages
  end
end
