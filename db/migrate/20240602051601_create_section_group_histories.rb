class CreateSectionGroupHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :section_group_histories do |t|
      t.references :section_group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :action, null: false            
      t.timestamps
    end
  end
end
