class Invitation < ApplicationRecord
  belongs_to :invited_to_event, class_name: 'Event'
  belongs_to :event_attendee, class_name: 'User'
  validates_uniqueness_of :event_attendee, scope: 'invited_to_event_id', message: 'This member is already invited.'

  before_save :creator_cant_be_invited

  def date
    invited_to_event.event_date.strftime('%I:%M %P, %B %-d, %Y')
  end

  def accepted
    update(rsvp: true)
  end

  def declined
    update(rsvp: false)
  end

  private

  def creator_cant_be_invited
    event_attendee != invited_to_event.creator
  end
end
