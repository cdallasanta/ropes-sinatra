class CreateInspections < ActiveRecord::Migration
  def change
    t.date :climb_date
    t.string :comments
    t.integer :user_id
    t.integer :element_id
    t.timestamps
  end
end
