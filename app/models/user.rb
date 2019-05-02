class User < ActiveRecord::Base
  has_many :inspections

  validates_presence_of :fullname, :username, :password
  validates :username, uniqueness: { message: "Username: \"%{value}\" is already taken" }
  has_secure_password
end
