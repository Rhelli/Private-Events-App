class User < ApplicationRecord
  has_many :events, foreign_key: :creator_id, class_name: 'Event'
  has_many :invitations, foreign_key: :event_attendee_id
  has_many :invited_to_events, through: :invitations

  before_save { self.name = name.downcase }
  validates :name, presence: true, length: { maximum: 100 }, allow_nil: false

  def hosted_events
    events.created_event
  end

  def invites
    invitations.where('rsvp is null').order(created_at: :desc)
  end

  def upcoming_events
    invited_to_events.where('event_date > ? AND rsvp = ?', Time.now, true).order(event_date: :asc)
  end

  def past_events
    invited_to_events.where('event_date < ?', Time.now).order(date: :desc)
  end
end
