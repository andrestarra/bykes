class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.string :plan
      t.string :code
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end