class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.string :booking_id
      t.string :amount
      t.string :payment_method
      t.string :transaction_id
      t.string :status
      t.string :paid_at

      t.timestamps
    end
  end
end
