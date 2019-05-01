class Element < ActiveRecord::Base
  has_many :ropes
  has_many :inspections
end
