require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:user) { User.create!(id: '1', name: 'Test') }
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
  end
end
