class AddNewFieldToSectionGroup < ActiveRecord::Migration[7.1]
  def change
    add_column :section_groups, :travel_date, :datetime
  end
end
