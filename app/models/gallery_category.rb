# encoding: utf-8

class GalleryCategory < ActiveRecord::Base
  validates_presence_of :title  
  has_many :gallery, :dependent=> :destroy
end
