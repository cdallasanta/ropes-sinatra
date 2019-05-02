class Rope < ActiveRecord::Base
  belongs_to :element
  has_many :climbs

  def total_climbs
    num = 0
    self.climbs.each do |climb|
      num += climb.number_of_climbs
    end
    num
  end
end
