# encoding: utf-8

class TemplateType < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :product
  has_many :template
end
