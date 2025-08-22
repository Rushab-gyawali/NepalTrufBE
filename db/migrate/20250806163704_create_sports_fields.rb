class CreateSportsFields < ActiveRecord::Migration[8.0]
  def change
    create_table :sports_fields do |t|
      t.string :name
      t.string :owner_id
      t.string :field_type
      t.string :address
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :hourly_rate
      t.string :description
      t.string :image_url
      t.boolean :is_active

      t.timestamps
    end
  end
end
