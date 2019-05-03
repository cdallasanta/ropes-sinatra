class Rope < ActiveRecord::Base
  belongs_to :element
  has_many :climbs

  validates_presence_of :primary_color, { message: "Primary color cannot be blank"}
  validates_presence_of :pcord_color, { message: "Pcord color cannot be blank"}

  def total_climbs
    num = 0
    self.climbs.each do |climb|
      num += climb.number_of_climbs
    end
    num
  end
end
