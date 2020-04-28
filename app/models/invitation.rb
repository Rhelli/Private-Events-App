class Invitation < ApplicationRecord
  belongs_to :invited_to_event, class_name: 'Event'
  belongs_to :event_attendee, class_name: 'User'
end
