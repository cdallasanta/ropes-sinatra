class Rope < ActiveRecord::Base
  has_many :inspections, through: :elements
  belongs_to :element

  def log_climbs(climb_num)
    self.total_climbs += climb_num
    self.save
  end
end
