class CreateBikes < ActiveRecord::Migration[5.2]
  def change
    create_table :bikes do |t|
      t.string :serial_number
      t.string :state
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end
