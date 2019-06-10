class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.string :address
      t.integer :available_bikes, default: 0

      t.timestamps
    end
  end
end
