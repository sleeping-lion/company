# encoding: utf-8

class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.references :user,:null=>false
      t.string :title,:limit=>60,:null=>false
      t.timestamps
    end
    
    create_table :notice_contents do |t|
      t.text :content,:null=>false
    end
    
    add_index :notices, :user_id
  end
end
