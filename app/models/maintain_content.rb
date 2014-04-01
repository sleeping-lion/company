# encoding: utf-8

class MaintainContent < ActiveRecord::Base
  validates_presence_of :content
  belongs_to :maintain, :foreign_key => :id, :autosave=>true
  accepts_nested_attributes_for :maintain, :allow_destroy => true
end
