class Inspection < ActiveRecord::Base
  belongs_to :element
  belongs_to :user
  has_many :climbs

  validates_presence_of :climb_date, { message: "Date cannot be blank"}
  validates_presence_of :user_id, :element_id
end
