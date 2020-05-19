require 'rails_helper'
include SessionsHelper

RSpec.describe EventsController, type: :controller do
  let!(:user1) { User.create!(name: 'Test') }
  let!(:user2) { User.create!(name: 'Test2') }
  let!(:event1) { Event.create!(name: 'Sample Event', event_date: '2019-08-08 20:00:00 UTC', created_at: '2018-03-01 10:00:00 UTC', updated_at: '2018-03-01 10:00:00 UTC', creator_id: '2', description: 'blah') }
  let!(:event2) { Event.create!(name: 'Sample Event Dos', event_date: '2022-08-08 20:00:00 UTC', created_at: '2020-03-01 10:00:00 UTC', updated_at: '2020-03-01 10:00:00 UTC', creator_id: '2', description: 'dos blah') }
  let(:create_event) { post :create, params: { event: { name: 'Tester', event_date: '2021-05-05 20:00:00 UTC', description: 'something or other'} } }
  
  context 'displaying the events index' do
    it 'should display all the upcoming events in descending (created) order' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(assigns(:upcoming_events)).to eq([event2])
    end

    it 'should display all the past events in descending (created) order' do
      get :index
      expect(assigns(:past_events)).to eq([event1])
    end
  end

  context 'creating a new event' do
    before { log_in(user1) }
    it 'should create the event with the current user as the host' do
      expect(user2.events.count).to eq(2)
      expect(@current_user.events.count).to eq(0)
      create_event
      expect(@current_user.events.count).to eq(1)
    end

    it 'should redirect the user to the event and display a flash message upon creation' do
      create_event
      expect(response).to redirect_to('/events/3')
      expect(flash[:success]).to be_present
    end

    it 'should render the page again if incorrect params are entered' do
      post :create, params: { event: { name: 'Missing Description', event_date: '2021-05-05 20:00:00 UTC'} }
      expect(response).to render_template(:new)
      expect(flash[:danger]).to be_present
    end
  end

  context 'showing an individual event' do
    it 'should render show page for an individual event' do
      log_in(user2)
      get :show, params: { id: '2' }
      expect(response).to have_http_status(:success)
    end
  end
end