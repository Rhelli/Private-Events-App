require 'rails_helper'
include SessionsHelper

RSpec.describe EventsController, type: :controller do
  let!(:user1) { User.create!(name: 'Test') }
  let!(:user2) { User.create!(name: 'Test2') }
  let!(:event1) { Event.create!(name: 'Sample Event', event_date: '2019-08-08 20:00:00 UTC', created_at: '2018-03-01 10:00:00 UTC', updated_at: '2018-03-01 10:00:00 UTC', creator_id: '1', description: 'blah') }
  let!(:event2) { Event.create!(name: 'Sample Event Dos', event_date: '2022-08-08 20:00:00 UTC', created_at: '2020-03-01 10:00:00 UTC', updated_at: '2020-03-01 10:00:00 UTC', creator_id: '1', description: 'dos blah') }
  
  context 'showing the events index' do
    it 'should display all the events in descending (created) order' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(assigns(:events)).to eq([event2, event1])
    end
  end

  context 'creating a new event' do
    it 'should create the event with the current user as the host' do
      expect(event1.creator.id).to eq(user1.id)
      expect(user2.events.count).to eq(0)
    end
  end
end