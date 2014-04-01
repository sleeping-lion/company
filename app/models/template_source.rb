# encoding: utf-8

class TemplateSource < ActiveRecord::Base
  validates_presence_of :name
  has_many :template, :through=>:templates_template_sources  
end
