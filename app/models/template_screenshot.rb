# encoding: utf-8

class TemplateScreenshot < ActiveRecord::Base
  validates_presence_of :template_id, :uri
end
