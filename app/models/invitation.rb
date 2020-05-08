class Invitation < ApplicationRecord
  belongs_to :invited_to_event, class_name: 'Event'
  belongs_to :event_attendee, class_name: 'User'
  belongs_to :inviter, class_name: 'User'
  validates_uniqueness_of :event_attendee, scope: 'invited_to_event_id', message: 'This member is already invited.'

  def accepted
    self.update(rsvp: true)
  end

  def declined
    self.update(rsvp: false)
  end
end
