class AddOrganizationToUser < ActiveRecord::Migration[8.0]
  def change
    remove_column :sports_fields, :owner_id, :string
    add_column :users, :organization_id, :string
    add_column :sports_fields, :organization_id, :string
    add_column :bookings, :organization_id, :string
  end
end
