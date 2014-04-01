class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, :null=>false, :limit=>60
      t.string :description, :null=>false
      t.string :photo
      t.boolean :enable, :null=>false, :default=>true      
      t.timestamps
    end
  end
end
