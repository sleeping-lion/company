# encoding: utf-8

class ProductOptions < ActiveRecord::Base
  validates_presence_of :title, :description
  belongs_to :product, :autosave=>true
end
