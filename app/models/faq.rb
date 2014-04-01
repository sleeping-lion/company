# encoding: utf-8

class Faq < ActiveRecord::Base
  validates_presence_of :title
  belongs_to :faq_category, :autosave=>true
  has_one :faq_content, :foreign_key => :id, :dependent=>:destroy
  accepts_nested_attributes_for :faq_content, :allow_destroy => true  
end
