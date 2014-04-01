# encoding: utf-8

class Notice < ActiveRecord::Base
  is_impressionable  
  validates_presence_of :title
  belongs_to :user, :autosave=>true
  has_one :notice_content, :foreign_key => :id, :dependent => :destroy
  accepts_nested_attributes_for :notice_content, :allow_destroy => true
end
