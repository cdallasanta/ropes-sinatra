class Rope < ActiveRecord::Base
  has_many :inspections, through: :elements
  belongs_to :element
end
