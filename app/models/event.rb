class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invitations, foreign_key: :invited_to_event_id
  has_many :attendees, through: :invitations, source: :event_attendee

  #def attendees
  #  self.attendees.where('rsvp = ?', true)
  #end
end
