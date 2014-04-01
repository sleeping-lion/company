class CreateTemplateSoftwaresTemplates < ActiveRecord::Migration
  def change
    create_table :template_softwares_templates, :id => false do |t|
      t.references :template, :template_software
    end
  end
end
