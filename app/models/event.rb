class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :invitations, foreign_key: :invited_to_event_id
  has_many :attendees, through: :invitations, source: :event_attendee

  before_save { self.name = name.downcase.capitalize }
  validates :name, presence: true, length: { maximum: 120 }, allow_nil: false
  validates :event_date, presence: true
  validates :description, presence: true, length: { maximum: 20_000 }
  validates :creator_id, presence: true
end
