class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :points
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
