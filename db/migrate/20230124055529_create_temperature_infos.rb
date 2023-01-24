class CreateTemperatureInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :temperature_infos do |t|
      t.integer :location
      t.integer :time
      t.float :value
      t.string :unit

      t.timestamps

      t.index [:location, :time], unique: true, name: 'by_location_time'
    end
  end
end
