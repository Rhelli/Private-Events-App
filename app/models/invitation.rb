class Invitation < ApplicationRecord
  belongs_to :invited_to_event, class_name: 'Event'
  belongs_to :event_attendee, class_name: 'User'

  def accepted
    self.update(rsvp: true)
  end

  def declined
    self.update(rsvp: false)
  end
end
