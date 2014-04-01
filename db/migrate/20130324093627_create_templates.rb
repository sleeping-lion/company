class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :title, :limit=>60
      t.references :template_type, :null=>false
      t.references :template_author, :null=>false
      t.references :template_package, :null=>false
      t.integer :state, :null=>false, :default=>0
      t.integer :price, :null=>false, :default=>0
      t.integer :exc_price, :null=>false, :default=>0
      t.integer :downloads, :null=>false, :default=>0
      t.boolean :is_flash, :null=>false, :default=>false
      t.boolean :is_adult, :null=>false, :default=>false
      t.boolean :is_full_site, :null=>false, :default=>false
      t.boolean :is_real_size, :null=>false, :default=>false
      t.boolean :is_recommend, :null=>false, :default=>false
      t.boolean :is_main, :null=>false, :default=>false
      t.datetime :inserted_date
      t.datetime :update_date
      t.string :keywords
      t.string :main_screenshot
      t.string :small_screenshot
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps
    end
    
    add_index :templates, :template_type_id
    add_index :templates, :template_author_id
    add_index :templates, :template_package_id       
  end
end
