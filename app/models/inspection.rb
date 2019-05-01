class Inspection < ActiveRecord::Base
  has_many :ropes, through: :elements
  belongs_to :element
end
