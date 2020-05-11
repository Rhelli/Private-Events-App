require 'rails_helper'

RSpec.describe Invitation, type: :model do
  context 'Invitation model associations' do
    it "belongs to an invited_to_event" do
      x = Invitation.reflect_on_association(:invited_to_event)
      expect(x.macro).to eq(:belongs_to)
    end

    it 'belongs to the event_attendee' do
      x = Invitation.reflect_on_association(:event_attendee)
      expect(x.macro).to eq(:belongs_to)
    end
  end

  context 'tests for methods defining if the invite is accepted or declined' do

  end
end