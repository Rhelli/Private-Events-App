class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invitations, foreign_key: :invited_to_event_id
  has_many :attendees, through: :invitations, source: :event_attendee

  scope :owned_event, -> { where(:creator == current_user.id) }
end
