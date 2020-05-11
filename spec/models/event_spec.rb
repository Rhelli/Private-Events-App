require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:user) { User.create!(id: '1', name: 'Test') }

  context 'Event Model Associations' do
    it 'belongs to :creator' do
      x = Event.reflect_on_association(:creator)
      expect(x.macro).to eq(:belongs_to)
    end

    it 'has_many_invitations' do
      x = Event.reflect_on_association(:invitations)
      expect(x.macro).to eq(:has_many)
    end

    it 'has many attendees' do
      x = Event.reflect_on_association(:attendees)
      expect(x.macro).to eq(:has_many)
    end
  end

  context 'Event model validations' do
    it "it validates correct event creation config" do
      user
      event = Event.create!(name: 'Test', event_date: '2020-06-08 22:00:00 UTC', creator_id: '1', description: 'magnets')
      expect(event).to be_truthy
    end

    it "rejects an event without a given name" do
      user
      event = Event.new(name: ' ', event_date: '2020-06-08 22:00:00 UTC', creator_id: '1', description: 'magnets')
      expect(event).to_not be_valid
    end

    it "rejects an event with a name over 120 characters" do
      user
      event = Event.new(name: 'Milksteak' * 121 , event_date: '2020-06-08 22:00:00 UTC', creator_id: '1', description: 'magnets')
      expect(event).to_not be_valid
    end

    it 'saves the events name to capitalized downcase before saving' do
      event = Event.create!(name: "sam's lame birthday party", event_date: '2020-06-08 22:00:00 UTC', creator_id: '1', description: 'magnets' )
      expect(event.reload.name).to eq("Sam's lame birthday party")
    end

    it 'rejects an event without an event date' do
      event = Event.new(name: 'Test', creator_id: '1', description: 'magnets')
      expect(event).to_not be_valid
    end

    it "rejects an event with a description of over 20_000 characters" do
      user
      event = Event.new(name: 'Test', event_date: '2020-06-08 22:00:00 UTC', creator_id: '1', description: 'spaghetti policy' * 20_001)
      expect(event).to_not be_valid
    end

    it "rejects an event without a creator/creator_id attached" do
      user
      event = Event.new(name: 'Test', event_date: '2020-06-08 22:00:00 UTC', creator_id: nil, description: 'spaghetti policy')
      expect(event).to_not be_valid
    end
  end
end
