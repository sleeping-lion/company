# encoding: utf-8

class TemplateAuthor < ActiveRecord::Base
  validates_presence_of :name
  has_many :template  
end
