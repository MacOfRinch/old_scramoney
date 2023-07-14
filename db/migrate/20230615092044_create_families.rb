class CreateFamilies < ActiveRecord::Migration[7.0]
  def change
    create_table :families, id: false do |t|
      t.string :id, limit: 36, primary_key: true, null: false
      t.string :name
      t.string :nickname
      t.string :avatar
      t.integer :budget

      t.timestamps
    end
  end
end
