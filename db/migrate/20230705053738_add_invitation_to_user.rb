class AddInvitationToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :invite_digest, :string
    add_column :users, :invite_sent_at, :datetime
  end
end
