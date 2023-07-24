class CreateFamilies < ActiveRecord::Migration[7.0]
  def change
    create_table :families do |t|
      t.string :name
      t.string :nickname
      t.string :avatar
      t.integer :budget

      t.timestamps
    end
  end
end
