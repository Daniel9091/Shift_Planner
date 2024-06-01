class CreatePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :places do |t|
      t.string :name, null: false
      # Tiempos de creacion y de modificacion
      t.timestamps
    end
  end
end
