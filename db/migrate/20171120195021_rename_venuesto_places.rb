class RenameVenuestoPlaces < ActiveRecord::Migration[5.0]
  def change
    rename_table :venues, :places
  end
end
