class CreateTemplateTypes < ActiveRecord::Migration
  def change
    create_table :template_types do |t|
      t.references :product     
      t.string :name, :null=>false, :limit=>60
      t.string :korean_name, :limit=>60
      t.boolean :enable, :null=>false, :default=>true
      t.timestamps
    end
    
    add_index :template_types, :product_id
  end
end
