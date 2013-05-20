class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation, :username
  validates_uniqueness_of :email, :username
end
