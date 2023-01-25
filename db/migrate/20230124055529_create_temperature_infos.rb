class CreateTemperatureInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :temperature_infos do |t|
      t.integer :location, null: false
      t.integer :time, null: false
      t.float :value, null: false
      t.string :unit

      t.timestamps

      t.index [:location, :time], unique: true, name: 'by_location_time'
    end
  end
end
