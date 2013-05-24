class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation, :username, :folders
  validates_uniqueness_of :email, :username

  has_many :folders

  def owner?(folder)
    true if self.id == folder.user_id
  end

  def gifs
    self.folders.collect { |folder| folder.gifs }.flatten
  end

end
