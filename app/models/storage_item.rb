class StorageItem < ActiveRecord::Base
  attr_accessible :name, :cost, :count, :production_time

  belongs_to :issue

  validate :name, :presence => true, :unique => true
  validate :cost, :presence => true
  validates :count, :presence => true
end
