# encoding: utf-8

class Question < ActiveRecord::Base
  is_impressionable  
  include AnonBoard
  validates_presence_of :title
  has_one :question_content, :foreign_key => :id, :dependent => :destroy
  has_many :question_comment, :dependent=> :destroy
  belongs_to :user, :autosave=>true
  accepts_nested_attributes_for :question_content, :allow_destroy => true
  accepts_nested_attributes_for :question_comment, :allow_destroy => true 
end