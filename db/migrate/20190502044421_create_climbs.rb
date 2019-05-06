class CreateClimbs < ActiveRecord::Migration[5.1]
  def change
    create_table :climbs do |t|
      t.integer :number_of_climbs
      t.integer :rope_id
      t.integer :inspection_id
    end
  end
end
