class CreateFamilies < ActiveRecord::Migration[7.0]
  def change
    create_table :families do |t|
      t.string :family_name, null: false
      t.string :family_nickname
      t.string :family_avatar
      t.integer :budget, null: false
      t.integer :budget_of_last_month

      t.timestamps
    end
  end
end
