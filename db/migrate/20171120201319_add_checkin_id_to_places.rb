class AddCheckinIdToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :checkin_id, :string
  end
end
