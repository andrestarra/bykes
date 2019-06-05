class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.string :plan
      t.string :code, index: true
      t.references :user, foreign_key: true
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end
