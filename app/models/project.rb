# encoding: utf-8

require 'carrierwave/orm/activerecord'

class Project < ActiveRecord::Base
  validates_presence_of :title, :description, :photo
  mount_uploader :photo, ProjectUploader
end
