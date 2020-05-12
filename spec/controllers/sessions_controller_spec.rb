require 'rails_helper'
include SessionsHelper

RSpec.describe SessionsController, type: :controller do
  let(:user) { User.create!(name: 'Test') }
  
  context 'logging in' do
    it 'should log in the user when provided the correct params' do
      user
      log_in(user)
      expect(@current_user).to_not be(nil)
    end

    it 'should store the current users id in a session cookie upon logging in' do
      post :create, params: { session: { name: user.name } }
      expect(session[:user_id]).to eq(@current_user)
    end

    it 'should reject incorrect login params and refresh the page' do
      post :create, params: { session: { name: 'something' } }
      expect(session[:user_id]).to be(nil)
      expect(response).to render_template(:new)
    end

    context 'logging out' do
      it 'should log out the user' do
        log_in(user)
        delete :destroy
        expect(session[:user_id]).to be(nil)
      end
    end
  end

end