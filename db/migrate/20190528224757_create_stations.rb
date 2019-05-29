class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.string :address
      t.string :total_positions
      t.string :available_positions

      t.timestamps
    end
  end
end
