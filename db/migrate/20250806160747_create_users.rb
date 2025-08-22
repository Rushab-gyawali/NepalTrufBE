class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :password_digest
      t.string :role
      t.boolean :status

      t.timestamps
    end
  end
end
