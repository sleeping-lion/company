# encoding: utf-8

class PortfolioContent < ActiveRecord::Base
  validates_presence_of :content
  belongs_to :portfolio, :foreign_key => :id, :autosave=>true
  accepts_nested_attributes_for :portfolio, :allow_destroy => true
end
