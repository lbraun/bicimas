class CreateStations < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.integer :number
      t.decimal :coordinate_x
      t.decimal :coordinate_y
      t.string :name

      t.timestamps
    end
  end
end
