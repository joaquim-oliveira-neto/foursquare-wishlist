class DeleteColumnFromPlaces < ActiveRecord::Migration[5.0]
  def change
    remove_column :places, :venue_id
  end
end
