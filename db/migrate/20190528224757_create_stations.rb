class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.string :address
      t.string :available_bikes

      t.timestamps
    end
  end
end
