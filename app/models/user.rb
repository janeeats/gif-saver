class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation, :username, :folders

  validates :email, :password, :password_confirmation, :username, :presence => true, :on => :create
  validates_uniqueness_of :email, :username

  has_many :folders

  has_many :identities
  
  def slug
    username
  end

  def to_param
    "#{id}-#{slug}".parameterize
  end

  def gifs
    self.folders.collect { |folder| folder.gifs }.flatten
  end

  def has_identity?(auth_provider)
    identity_array = self.identities.collect {|identity| identity.provider}
    identity_array.include?(auth_provider)
  end

  def facebook_token
    identities.find_by_provider("facebook").token
  end

  def facebook
    @facebook ||= Koala::Facebook::API.new(facebook_token)
  end
  
end