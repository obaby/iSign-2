require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class }

  permissions :create? do
    it 'should allow access to register users' do
      user = build(:user)
      expect(subject).to permit(nil, user)
    end
  end

  permissions :show? do
    it 'should grant access if user is current_user' do
      user = build(:user)
      expect(subject).to permit(user, user)
    end

    it 'should not grant access if user is not current_user' do
      user = build(:user)
      fake = create(:user, email: 'fake@example.com')
      expect(subject).not_to permit(user, fake)
      expect(subject).not_to permit(fake, user)
    end
  end
end
