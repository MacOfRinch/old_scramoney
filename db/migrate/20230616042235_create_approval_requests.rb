class CreateApprovalRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :approval_requests do |t|
      t.string :suggested_task_title, null: false
      t.text :suggested_task_description
      t.integer :suggested_task_points, null: false
      t.integer :status, default: 0, null: false, limit: 1
      t.references :task, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
