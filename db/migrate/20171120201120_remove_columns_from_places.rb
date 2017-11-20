class RemoveColumnsFromPlaces < ActiveRecord::Migration[5.0]
  def change
    remove_column :places, :venue_photo, :string
    remove_column :places, :venue_name, :string
    remove_column :places, :user_photo, :string
  end
end
