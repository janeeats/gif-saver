class Folder < ActiveRecord::Base
  attr_accessible :name, :gifs_attributes
  validates :name, :presence => true

  belongs_to :user
  has_many :gifs
  accepts_nested_attributes_for :gifs

  extend FriendlyId
  friendly_id :name, :use => [:slugged, :history]

end
