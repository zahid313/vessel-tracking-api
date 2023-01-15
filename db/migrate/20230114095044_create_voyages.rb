class CreateVoyages < ActiveRecord::Migration[7.0]
  def change
    create_table :voyages do |t|
      t.string :from_place
      t.string :to_place
      t.datetime :start_at
      t.datetime :end_at
      t.references :vessel, null: false, foreign_key: true

      t.timestamps
    end
    add_index :voyages, :from_place
    add_index :voyages, :to_place
    add_index :voyages, :start_at
    add_index :voyages, :end_at
  end
end
