class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      # Datos del usuario minimos
      t.string :name, null: false                # Revisar Devise    # Obligatorio
      t.string :email, null: false               # Revisar Devise    # Obligatorio
      t.string :password_digest, null: false     # Revisar Devise    # Obligatorio
      t.string :phone, null: false                                   # Obligatorio
      t.string :description, default: nil
      # Datos bancarios para transferencia              # Nesesarios para transferencias como piloto
      t.string :data_name, default: nil
      t.string :data_rut, default: nil
      t.string :account_type, default: nil
      t.string :n_account, default: nil
      t.string :banc, default: nil
      t.string :data_email, default: nil
      # Valoraciones del usuario                        # Autogenerados
      t.integer :driver_review, default:1
      t.integer :n_driver_review, default:0
      t.integer :passenger_review, default:1
      t.integer :n_passenger_review, default:0
      # Datos administativos
      t.boolean :first_login, default: false
      # Tiempos de creacion y de modificacion
      t.timestamps
    end
  end
end