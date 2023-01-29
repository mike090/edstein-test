class RemoveUnitFromTemperatureInfos < ActiveRecord::Migration[6.1]
  def change
    remove_column :temperature_infos, :unit
  end
end
