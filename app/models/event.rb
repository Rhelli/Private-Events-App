class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invitations, foreign_key: :invited_to_event_id
  has_many :attendees, through: :invitations, source: :event_attendee

  before_save { self.name = name.downcase.capitalize! }
  validates :name, presence: true, length: { maximum: 120 }, allow_nil: false
  validates :event_date, presence: true
  validates :description, presence: true, length: { maximum: 20_000 }
  validates :creator_id, presence: true

  scope :upcoming_events, -> { where('event_date >= ?', Time.now).order(date: :desc).includes(:creator) }
  scope :past_events, -> { where('event_date < ?', Time.now).order(date: :desc).includes(:creator) }
  scope :created_event, -> { where('creator_id', @current_user) }

  def date
    event_date.strftime('%I:%M %P, %B %-d, %Y')
  end
end
