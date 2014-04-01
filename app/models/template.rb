# encoding: utf-8

class Template < ActiveRecord::Base
  validates_presence_of  :template_author, :template_type, :template_package, :state, :price, :exc_price, :downloads, :keywords, :inserted_date, :update_date, :message =>'필수값이 입력되지 않았습니다.'
  belongs_to :template_author
  belongs_to :template_type
  belongs_to :template_package
  has_and_belongs_to_many :template_categories
  has_and_belongs_to_many :template_sources
  has_and_belongs_to_many :template_softwares
end
