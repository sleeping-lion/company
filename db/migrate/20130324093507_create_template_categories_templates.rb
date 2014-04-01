class CreateTemplateCategoriesTemplates < ActiveRecord::Migration
  def change
    create_table :template_categories_templates, :id => false do |t|
      t.references :template, :template_category
    end
  end
end
