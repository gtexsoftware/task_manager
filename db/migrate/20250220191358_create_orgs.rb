class CreateOrgs < ActiveRecord::Migration[8.0]
  def change
    create_table :orgs do |t|
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
