# encoding: utf-8

class CreateResourcePhotos < ActiveRecord::Migration
  def change
    create_table :resource_photos do |t|
      t.references :resource, :null=>false
      t.string :photo, :null=>false
      t.string :alt,:limit=>60, :null=>false
      t.boolean :enable, :null=>false, :default=>1
      t.timestamps
    end
    
    add_index :resource_photos, :resource_id
  end
end
