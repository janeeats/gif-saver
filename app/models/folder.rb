class Folder < ActiveRecord::Base
  attr_accessible :name, :gifs_attributes
  validates :name, :presence => true

  belongs_to :user
  has_many :gifs
  accepts_nested_attributes_for :gifs

  def slug
    name.downcase.gsub(" ", "-").gsub("!", "").gsub(".", "").gsub("'", "").gsub("?", "")
  end

  def to_param
    "#{id}-#{slug}"
  end

end
