class Rope < ActiveRecord::Base
  belongs_to :element
  has_many :climbs

  def log_climbs(climb_num)
    self.total_climbs += climb_num
    self.save
  end
end
