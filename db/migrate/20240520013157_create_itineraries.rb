class CreateItineraries < ActiveRecord::Migration[7.1]
  def change
    create_table :itineraries do |t|
      t.string :status,     null: false                  # pasagero o conductor
      t.boolean :is_active, null: false, default: true   # itinerario activo o desactivado
      t.string :day,        null: false
      t.string :h_start,    null: false                   # proximanente cambie el tipo de dato a Date
      t.string :h_end,      null: false                   # proximamente cambie el tipo de dato a Date
      # Tiempos de creacion y de modificacion
      t.timestamps
    end
  end
end
