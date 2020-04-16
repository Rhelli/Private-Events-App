RSpec.describe User, type: :controller do
  it 'creates new session for the user' do
    user = User.create!(name: 'Test')
    log_in user
  end
    
  end
end