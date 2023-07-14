class AddFamilyUserRelation < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :family, type: :string, foreign_key: true
  end
end
