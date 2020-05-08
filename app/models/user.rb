class User < ApplicationRecord
  has_many :events, foreign_key: :creator_id, class_name: 'Event'
  has_many :invitations, foreign_key: :event_attendee_id
  has_many :invited_to_events, through: :invitations

  before_save { self.name = name.downcase }
  validates :name, presence: true, length: { maximum: 30 }, allow_nil: false


  def upcoming_events
    self.events.where('event_date >= ?', Time.now).order(date: :asc)
  end

  def past_events
    self.events.where('event_date < ?', Time.now).order(date: :desc)
  end

end