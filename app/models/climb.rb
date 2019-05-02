class Climb < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :rope
end
