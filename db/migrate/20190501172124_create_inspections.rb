class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.date :climb_date
      t.string :comments
      t.integer :user_id
      t.integer :element_id
      #number of climbs?
      t.timestamps
    end
  end
end
