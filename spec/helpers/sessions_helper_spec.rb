require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  it 'stores the users name in the session cookie' do
    user = User.create!(name: 'Test')
    log_in user
    expect(session[:name]).to eq("#{user.name}")
  end
end
