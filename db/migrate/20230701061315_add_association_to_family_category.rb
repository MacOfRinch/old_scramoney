class AddAssociationToFamilyCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :family, type: :string, foreign_key: true
  end
end
