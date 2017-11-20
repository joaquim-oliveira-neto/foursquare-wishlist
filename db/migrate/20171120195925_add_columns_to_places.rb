class AddColumnsToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :venue_photo, :string
    add_column :places, :venue_name, :string
    add_column :places, :user_photo, :string
  end
end
