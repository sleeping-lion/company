class CreateTemplateScreenshots < ActiveRecord::Migration
  def change
    create_table :template_screenshots do |t|
      t.references :template
      t.string :uri, :null=>false
      t.boolean :small_preview, :null=>false, :default=>false
      t.boolean :main_preview, :null=>false, :default=>false
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps
    end
    
    add_index :template_screenshots, :template_id    
  end
end
