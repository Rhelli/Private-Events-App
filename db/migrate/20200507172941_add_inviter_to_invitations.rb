class AddInviterToInvitations < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :inviter, :integer
  end
end
