class CreateStationStatusRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :station_status_records do |t|
      t.integer :station_id
      t.integer :bikes_total
      t.integer :bikes_available
      t.string :anchors
      t.datetime :last_seen
      t.boolean :online
      t.string :ip
      t.integer :number_loans

      t.timestamps
    end
  end
end
