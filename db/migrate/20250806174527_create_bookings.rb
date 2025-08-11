class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.string :user_id
      t.string :sports_field_id
      t.datetime :start_time
      t.datetime :end_time
      t.string :status
      t.decimal :total_price
      t.string :payment_status

      t.timestamps
    end
  end
end
