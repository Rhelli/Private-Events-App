class AddUniqueIndexToInvitation < ActiveRecord::Migration[6.0]
  def change
    add_index :invitations, [:event_attendee_id, :invited_to_event_id], unique: true
  end
end
