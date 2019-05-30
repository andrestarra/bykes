class CreateBikes < ActiveRecord::Migration[5.2]
  def change
    create_table :bikes do |t|
      t.string :serial_number
      t.string :state

      t.timestamps
    end
  end
end
