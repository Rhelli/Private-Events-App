require 'rails_helper'
include SessionsHelper

RSpec.describe UsersController, type: :controller do
  let!(:user1) { User.create!(name: 'Test') }
  let!(:user2) { User.create!(name: 'Test2') }
  let!(:event1) { Event.create!(name: 'Past Event', event_date: '2019-01-01 01:00:00 UTC', created_at: '2018-12-12 12:00:00 UTC', updated_at: '2018-12-12 12:00:00 UTC', creator_id: '2', description: 'Afterparty') }
  let!(:event2) { Event.create!(name: 'Future Event', event_date: '2021-01-01 01:00:00 UTC', created_at: '2020-01-01 12:00:00 UTC', updated_at: '2020-01-01 12:00:00 UTC', creator_id: '2', description: 'Afterparty') } 
  context 'creating a new user' do
    it 'logs in and redirects a new user to their profile with a flash message' do
      post :create, params: { user: { name: 'Test3' } }
      expect(response).to redirect_to('/users/3')
      expect(flash[:success]).to be_present
    end

    it 'incorrect params reload the page' do
      post :create, params: { user: { description: 'this is wrong' } }
      expect(response).to render_template(:new)
      expect(flash[:danger]).to be_present
    end
  end

  context 'showing a users profile page' do
    before { log_in(user1) }
    it 'finds the user profile by their id' do
      get :show, params: { id: '1' }
      expect(response).to render_template(:show)
    end

    it 'shows users upcoming events' do
      expect(user1.upcoming_events.count).to eq(0)
      Invitation.create!(event_attendee_id: '1', invited_to_event_id: '2', created_at: '2018-12-12 12:30:00 UTC', updated_at: '2018-12-12 12:30:00 UTC', rsvp: 'false')
      expect(user1.upcoming_events.count).to eq(1)
    end

    it 'shows a users past events' do
      expect(user1.past_events.count).to eq(0)
      Invitation.create!(event_attendee_id: '1', invited_to_event_id: '1')
      expect(user1.past_events.count).to eq(1)
    end
  end
end