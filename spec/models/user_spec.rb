require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Users names are formatted and validated' do
    it "saves the user's name to downcase" do
      user = User.create!(name: 'STEVE')
      expect(user.reload.name).to eq('steve')
    end

    it 'does not allow blank names to be saved' do
      user = User.new(name: nil)
      expect(user).to_not be_valid
    end

    it 'expects the users name to be under 31 chars' do
      user = User.new(name: 'a'* 31)
      expect(user).to_not be_valid
    end
  end
end

