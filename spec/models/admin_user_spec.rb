require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'devise modules' do
    it 'includes expected devise modules' do
      expect(AdminUser.devise_modules).to include(
                                            :database_authenticatable,
                                            :registerable,
                                            :recoverable,
                                            :rememberable,
                                            :validatable,
                                            :trackable
                                          )
    end
  end
end
