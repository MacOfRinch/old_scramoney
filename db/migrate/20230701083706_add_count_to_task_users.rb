class AddCountToTaskUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :task_users, :count, :integer, default: 1
  end
end
