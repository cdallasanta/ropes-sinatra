class User < ActiveRecord::Base
  has_many :inspections
  has_secure_password
end
