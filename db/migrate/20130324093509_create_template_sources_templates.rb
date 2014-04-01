class CreateTemplateSourcesTemplates < ActiveRecord::Migration
  def change
    create_table :template_sources_templates, :id => false do |t|
      t.references :template, :template_source
    end
  end
end
