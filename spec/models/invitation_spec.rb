require 'rails_helper'

RSpec.describe Invitation, type: :model do
  let(:user1) { User.create!(name: 'Test') }
  let(:user2) { User.create!(name: 'Test2') }
  let(:example_event) {  Event.create!(name: 'Boogietime', event_date: '2019-11-11 21:00:00 UTC', created_at: '2019-11-10 19:00:00 UTC', updated_at: '2019-11-10 19:00:00 UTC', creator_id: '1', description: 'Ghouls') }
  let(:example_invite) { Invitation.create!(event_attendee_id: '2', invited_to_event_id: '1', rsvp: nil, created_at: '2019-10-10 20:00:00 UTC', updated_at: '10-10-2019 20:00:00 UTC') }
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

  context 'it validates invitation creation' do
    it 'rejects duplicate invites to one user' do
      user1
      user2
      example_event
      example_invite
      invite = Invitation.new(event_attendee_id: '2', invited_to_event_id: '1', rsvp: 'false', created_at: '2019-10-10 20:00:00 UTC', updated_at: '10-10-2019 20:00:00 UTC')
      expect(invite).to_not be_valid
    end
  end

  context 'tests for methods defining if the invite is accepted or declined' do
    it 'updates the invitations rsvp column to true when accepted called' do
      user1
      user2
      example_event
      example_invite
      example_invite.accepted
      expect(example_invite.rsvp).to eq(true)
    end

    it "updates the invitation's rsvp column to false when the declined method is called" do
      user1
      user2
      example_event
      example_invite
      example_invite.declined
      expect(example_invite.rsvp).to eq(false)
    end
  end
end