# encoding: utf-8

class FaqCategory < ActiveRecord::Base
  validates_presence_of :title
  has_many :faq
end
