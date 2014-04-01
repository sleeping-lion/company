class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, :null=>false, :limit=>60
      t.integer :price, :null=>false, :default=>0
      t.integer :price_discount, :null=>false, :default=>0
      t.integer :page, :null=>false, :default=>0
      t.string :description, :null=>false
      t.string :program
      t.string :photo
      t.integer :make_day, :null=>false, :default=>7
      t.boolean :full, :null=>false, :default=>0
      t.boolean :main_show, :null=>false, :default=>0
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps
    end
    
    create_table :product_contents do |t|
      t.boolean :html,:default=>0,:null=>false
      t.text :content,:null=>false
    end    
  end
end
