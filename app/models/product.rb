# encoding: utf-8

class Product < ActiveRecord::Base
  validates_presence_of :title, :description
  belongs_to :user, :autosave=>true
  has_many :template_type
  has_one :product_content, :foreign_key => :id, :dependent => :destroy
  accepts_nested_attributes_for :product_content, :allow_destroy => true
  mount_uploader :photo, ProductUploader
end
