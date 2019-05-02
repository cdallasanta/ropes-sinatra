class Climb < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :rope

  validates :number_of_climbs,
    format: {
      with: /\A\d+\z/,
      message: "Please use positive integers"
    },
    allow_blank: true
end
