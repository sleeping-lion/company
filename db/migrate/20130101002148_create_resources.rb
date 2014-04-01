# encoding: utf-8

class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.references :ad_position, :null=>false   
      t.string :title, :limit=>60, :null=>false
      t.string :description
      t.string :controller, :limit=>60, :null=>false
      t.string :menu_action, :limit=>60, :null=>false, :default=>'index'
      t.boolean :use_category, :null=>false, :default=>false
      t.boolean :menu_display, :null=>false, :default=>true
      t.integer :per, :null=>false, :default=>10
      t.boolean :desc, :null=>false, :default=>true
      t.boolean :enable, :null=>false, :default=>true
      t.integer :priority, :null=>false, :default=>100
      t.timestamps
    end
    
    add_index :resources, :ad_position_id
    add_index :resources, :title, :unique => true    
    add_index :resources, :controller, :unique => true     
  end
end
