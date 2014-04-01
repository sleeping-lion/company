
class CreateMaintain < ActiveRecord::Migration
  def change
    create_table :maintain do |t|
      t.string :title, :null=>false, :limit=>60
      t.string :photo
      t.boolean :enable, :null=>false, :default=>true      
      t.timestamps
    end
    
    create_table :maintain_contents do |t|
      t.text :content,:null=>false
    end    
  end
end
