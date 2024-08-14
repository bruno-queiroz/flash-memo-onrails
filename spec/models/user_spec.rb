require 'rails_helper'

RSpec.describe 'User' do           
    it 'User Should NOT create user successfully.' do   
      user = FactoryBot.create(:user)

      expect(user).to be_valid
    end

    it "User name should be unique." do 
      user = FactoryBot.create(:user)

      expect {FactoryBot.create(:user)}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "User name cannot be blank." do
      user = FactoryBot.create(:user)
      user.name = ""
      expect(user).not_to be_valid
    end
end
