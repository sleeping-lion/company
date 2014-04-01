# encoding: utf-8

class ProductContent < ActiveRecord::Base
  validates_presence_of :content
  belongs_to :product, :foreign_key => :id, :autosave=>true
  accepts_nested_attributes_for :product, :allow_destroy => true
end
