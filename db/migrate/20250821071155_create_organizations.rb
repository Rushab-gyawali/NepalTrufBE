class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :organization_name
      t.string :slug
      t.string :organization_registered_date
      t.boolean :is_active

      t.timestamps
    end
  end
end
