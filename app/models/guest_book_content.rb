# encoding: utf-8

class GuestBookContent < ActiveRecord::Base
  validates_presence_of :content
  belongs_to :guest_book, :foreign_key => :id, :autosave=>true
  accepts_nested_attributes_for :guest_book, :allow_destroy => true  
end
