class CreateWhishlists < ActiveRecord::Migration[5.0]
  def change
    create_table :whishlists do |t|
      t.string :venue_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
