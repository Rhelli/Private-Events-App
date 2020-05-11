require 'rails_helper'

RSpec.describe User, type: :model do
    
  context 'Users names are formatted and validated' do
    it "saves the user's name to capitalized downcase" do
      user = User.create!(name: 'STEVE')
      expect(user.reload.name).to eq('Steve')
    end

    it 'does not allow blank names to be saved' do
      user = User.new(name: nil)
      expect(user).to_not be_valid
    end

    it 'expects the users name to be under 100 chars' do
      user = User.new(name: 'a' * 101)
      expect(user).to_not be_valid
    end
  end

  context 'Users associations are correctly named' do
    it 'should have many events' do
      x = User.reflect_on_association(:events)
      expect(x.macro).to eq(:has_many)
    end

    it 'should have many invitations' do
      x = User.reflect_on_association(:invitations)
      expect(x.macro).to eq(:has_many)
    end

    it 'should have many invite_to_events' do
      x = User.reflect_on_association(:invited_to_events)
      expect(x.macro).to eq(:has_many)
    end
  end

  context 'Users events are sorted into upcoming and past events' do
    it 'Sorts events as upcoming if they are yet to happen' do
      steve = User.create!(name: 'Steve')
      Event.create!(name: 'Test Party', event_date: '2200-04-02 22:00:00 UTC', created_at: '2020-04-02 22:00:00 UTC', updated_at: '2020-04-02 22:00:00 UTC', creator_id: '1', description: 'blah blah' )
      expect(steve.upcoming_events).to_not be(nil)
    end

    it 'Sorts events as past if they have already happened' do
      steve = User.create!(name: 'Steve')
      Event.create!(name: 'Test Party', event_date: '2001-04-02 22:00:00 UTC', created_at: '2000-04-02 22:00:00 UTC', updated_at: '2000-04-02 22:00:00 UTC', creator_id: '1', description: 'blah blah' )
      expect(steve.upcoming_events).to_not be(nil)
    end
  end
end

