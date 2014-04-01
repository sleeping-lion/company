# encoding: utf-8

class CreateGalleryCategories < ActiveRecord::Migration
  def change
    create_table :gallery_categories do |t|
      t.string :title,:null=>false
      t.boolean :enable, :null=>false, :default=>true      
      t.timestamps
    end
  end
end
