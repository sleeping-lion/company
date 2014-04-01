# encoding: utf-8

class QuestionContent < ActiveRecord::Base
  validates_presence_of :content  
  belongs_to :question, :foreign_key => :id, :autosave=>true
  accepts_nested_attributes_for :question, :allow_destroy => true
end
