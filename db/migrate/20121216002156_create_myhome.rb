# encoding: utf-8

class CreateMyhome < ActiveRecord::Migration
  def change
    create_table :myhome do |t|
      
      t.string :title,:limit=>60,:null=>false
      t.timestamps
    end
    
    create_table :myhome_contents do |t|
      t.text :content,:null=>false
    end
  end
end
