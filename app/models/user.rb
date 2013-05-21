class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation, :username, :folders
  validates_uniqueness_of :email, :username

  has_many :folders
end
