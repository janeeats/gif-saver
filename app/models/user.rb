class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation, :username, :folders

  validates :email, :password, :password_confirmation, :username, :presence => true, :on => :create
  validates_uniqueness_of :email, :username

  has_many :folders

  has_many :identities
  
  extend FriendlyId
  friendly_id :username

  def gifs
    self.folders.collect { |folder| folder.gifs }.flatten
  end

  def has_an_identity?
    true unless self.identities.empty?
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
  
  def twitter
    twitterclient = Twitter::Client.new(
      :oauth_token => twitter_token,
      :oauth_token_secret => twitter_token_secret)
  end

  def twitter_token
    identities.find_by_provider("twitter").token
  end

  def twitter_token_secret
    identities.find_by_provider("twitter").secret
  end

end