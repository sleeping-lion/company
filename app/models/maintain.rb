# encoding: utf-8

require 'carrierwave/orm/activerecord'

class Maintain < ActiveRecord::Base
  validates_presence_of :title
  has_one :maintain_content, :foreign_key => :id, :dependent => :destroy
  accepts_nested_attributes_for :maintain_content, :allow_destroy => true  
  mount_uploader :photo, MaintainUploader
end
