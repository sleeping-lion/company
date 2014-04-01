class CreateProductOptions < ActiveRecord::Migration
  def change
    create_table :product_options do |t|
      t.string :title, :null=>false, :limit=>60
      t.string :description  
      t.timestamps
    end  
  end
end
