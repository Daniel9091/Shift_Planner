class CreateSectionGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :section_groups do |t|
      t.string :n_seats, null: false
      t.integer :cost,   null: false
      t.string :h_start, null: false
      t.string :h_end,   null: false
      t.string :day,     null: false
      t.string :description, default: nil


      t.timestamps
    end
  end
end
