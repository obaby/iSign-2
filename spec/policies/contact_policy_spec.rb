require 'rails_helper'

RSpec.describe ContactPolicy do
  let(:subject) { described_class }

  permissions :show?, :update?, :destroy? do
    it 'should grant access to contact owner' do
      user = create(:user)
      contact = build(:contact, user: user)
      expect(subject).to permit(user, contact)
    end

    it 'should not grant access to other user' do
      user = create(:user)
      fake = build(:user, email: 'fake@example.com')
      contact = build(:contact, user: user)

      expect(subject).not_to permit(fake, contact)
    end
  end

  permissions :create? do
    it 'should grant access if user present' do
      user = create(:user)
      contact = build(:contact, user: user)
      expect(subject).to permit(user, contact)
    end

    it 'should not grant access if user is blank' do
      contact = build(:contact)
      expect(subject).not_to permit(nil, contact)
    end
  end

  permissions '.scope' do
    it 'it should return list of contacts for user' do
      user = create(:user)
      contact = create(:contact, user: user)
      contact2 = create(:contact,
                        user: user,
                        email: 'contact2@example.com')
      contact3 = create(:contact,
                        user: build(:user, email: 'test@example.com'),
                        email: 'contact3@example.com')
      policy_scope = ContactPolicy::Scope.new(user, Contact).resolve

      expect(policy_scope).to eq([contact, contact2])
      expect(policy_scope).not_to eq([contact, contact2, contact3])
    end
  end
end
