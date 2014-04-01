class CreateTemplateCategories < ActiveRecord::Migration
  def change
    create_table :template_categories do |t|
      t.string :name, :null=>false, :limit=>60
      t.string :korean_name, :limit=>60
      t.integer :count, :null=>false, :default=>0
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps
    end
  end
end
