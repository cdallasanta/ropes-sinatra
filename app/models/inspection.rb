class Inspection < ActiveRecord::Base
  belongs_to :element
  belongs_to :user
  has_many :climbs
end
