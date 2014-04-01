class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :title, :null=>false
      t.string :url, :null=>false
      t.text :description, :null=>false
      t.string :photo,:null=>false
      t.boolean :enable, :null=>false, :default=>true      
      t.timestamps
    end
    
    create_table :portfolio_contents do |t|
      t.text :content,:null=>false
    end
  end
end
