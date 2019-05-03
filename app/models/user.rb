class User < ActiveRecord::Base
  has_many :inspections

  validates_presence_of :fullname, { message: "Full Name cannot be blank"}
  validates_presence_of :username, :password, { message: "%{attribute} cannot be blank" }
  validates :username, uniqueness: { message: "Username: \"%{value}\" is already taken" }
  has_secure_password
end
