class CreateRopes < ActiveRecord::Migration
  def change
    create_table :ropes do |t|
      t.string :primary_color
      t.string :pcord_color
      t.integer :element_id
    end
  end
end
