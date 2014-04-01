# encoding: utf-8

require 'carrierwave/orm/activerecord'

class Gallery < ActiveRecord::Base
  validates_presence_of :title, :photo
  belongs_to :gallery_category
  mount_uploader :photo, GalleryPhotoUploader
end
