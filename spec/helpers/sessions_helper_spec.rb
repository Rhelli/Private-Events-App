require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { User.create!(name: 'Test')}

  it 'stores the users name in the session cookie' do
    log_in user
    expect(session[:name]).to eq("#{user.name}")
  end

  it 'sets the current user to the user' do
    log_in user
    expect(@current_user).to eq(user)
  end

  it 'checks if the current user exists' do
    log_in user
    expect(@current_user).to eq(user)
  end

  it 'checks if the current user in not nil' do
    log_in user
    expect(logged_in?).to be_truthy
  end

  context 'logs out user' do
    it 'deletes the session' do
      log_in user
      log_out user
      expect(session[:name]).to be_nil
      expect(@current_user).to be_nil
    end
  end

end
