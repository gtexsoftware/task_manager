class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.references :org, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.text :types
      t.string :phone_number

      t.timestamps
    end
  end
end
