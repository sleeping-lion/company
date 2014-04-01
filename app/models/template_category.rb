# encoding: utf-8

class TemplateCategory < ActiveRecord::Base
  validates_presence_of :name
  has_and_belongs_to_many :templates, :select=>'distinct templates.*'
end
