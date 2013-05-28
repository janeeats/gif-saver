class Folder < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true

  belongs_to :user
  has_many :gifs
  
  def slug
    name.downcase.gsub(" ", "-").gsub("!", "").gsub("*", "")
  end

  def to_param
    "#{id}-#{slug}"
  end

end
