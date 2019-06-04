class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.datetime :ends_at
      t.belongs_to :rental, index: { unique: true }, foreign_key: true
      t.references :bike, foreign_key: true
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end
