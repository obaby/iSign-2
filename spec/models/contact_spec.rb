require 'rails_helper'

RSpec.describe Contact, type: :model do
  context '.Validation' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  context '.Association' do
    it { should belong_to :user }
  end

  context '.owner?' do
    it 'should be owner' do
      user = create(:user)
      contact = create(:contact, user: user)

      expect(contact.owner?(user)).to be_truthy
    end

    it 'should not be an owner' do
      user = create(:user)
      fake = create(:user, email: 'fake@example.com')
      contact = create(:contact, user: user)

      expect(contact.owner?(fake)).to be_falsey
    end
  end
end
