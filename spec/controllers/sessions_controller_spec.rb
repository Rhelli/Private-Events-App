require 'rails_helper'
include SessionsHelper

RSpec.describe SessionsController, type: :controller do
  let(:user) { User.create!(name: 'Test') }
  
  it 'should log the user out' do
    log_in user
    delete :destroy
    expect(@current_user).to be_nil
    expect(session[:name]).to be_nil
    expect(response).to redirect_to(root_path)
    expect(flash[:success]).to be_present
  end
end