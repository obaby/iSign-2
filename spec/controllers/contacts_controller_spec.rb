require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:user) { create(:user) }
  let(:fake_user) { create(:fake_user) }
  let(:contact) { create(:contact, user: user) }

  context 'GET /contacts' do
    it 'should return 401 unauthorized access' do
      get :index, format: 'json'

      expect_status(401)
      expect_json(errors: 'Token is missing in the header request or it is invalid!')
    end

    it 'should return contacts for current loggedin user' do
      contact1 = create(:contact, email: 'a@example.com', user: user)
      contact2 = create(:contact, email: 'b@example.com', user: user)
      contact3 = create(:contact, user: build(:fake_user))
      request.headers.merge!(authenticated_header_for(user))
      get :index, format: 'json'

      expect_status(200)
      expect_json_sizes('data', 2)
      expect_json(
        'data.0',
        email: 'a@example.com',
        first_name: contact1.first_name,
        last_name: contact1.last_name
      )
      expect_json(
        'data.1',
        email: 'b@example.com',
        first_name: contact2.first_name,
        last_name: contact2.last_name
      )
    end
  end

  context 'GET /contacts/1' do
    it 'should return unauthorized access without token' do
      get :show, params: { id: contact.id }, format: 'json'
      expect_status(401)
      expect_json(errors: 'Token is missing in the header request or it is invalid!')
    end

    it 'should return unauthorized access for fake user' do
      request.headers.merge!(authenticated_header_for(fake_user))
      get :show, params: { id: contact.id }, format: 'json'
      expect_status(401)
      expect_json(errors: 'You are not authorized to perform this action')
    end

    it 'should return contact informaton if valid token' do
      request.headers.merge!(authenticated_header_for(user))
      get :show, params: { id: contact.id }, format: 'json'
      expect_status(200)
      expect_json(
        'data',
        id: contact.id,
        email: contact.email,
        first_name: contact.first_name,
        last_name: contact.last_name
      )
    end
  end

  context 'POST /contacts' do
    it 'should return unauthorized access without token' do
      post :create, format: 'json'
      expect_status(401)
      expect_json(errors: 'Token is missing in the header request or it is invalid!')
    end

    it 'should require contact param' do
      request.headers.merge!(authenticated_header_for(user))
      post :create, format: 'json'
      expect_status(422)
      expect_json(errors: 'param is missing or the value is empty: contact')
    end

    it 'should validate uniqueness of email' do
      request.headers.merge!(authenticated_header_for(user))
      post :create, params: {
        contact: { email: contact.email, first_name: contact.first_name, last_name: contact.last_name  }
      }, format: 'json'

      expect_status(422)
      expect_json('errors', { email: ['has already been taken'] })
    end

    it 'should create contact' do
      c = build(:contact, email: 'test@example.com')
      request.headers.merge!(authenticated_header_for(user))
      post :create, params: {
        contact: { email: c.email, first_name: c.first_name, last_name: c.last_name }
      }, format: 'json'

      expect_status(200)
      expect(Contact.count).to eq(1)
      expect_json('data', {
        email: c.email,
        first_name: c.first_name,
        last_name: c.last_name,
        user_id: user.id
      })
    end
  end

  context 'PUT /contact/:id' do
    it 'should return unauthorized access without token' do
      put :update, params: { id: contact.id }, format: 'json'
      expect_status(401)
      expect_json(errors: 'Token is missing in the header request or it is invalid!')
    end

    it 'should require contact param' do
      request.headers.merge!(authenticated_header_for(user))
      put :update, params: { id: contact.id }, format: 'json'
      expect_status(422)
      expect_json(errors: 'param is missing or the value is empty: contact')
    end

    it 'should be a valid user' do
      request.headers.merge!(authenticated_header_for(fake_user))
      put :update, params: { id: contact.id, contact: { fake: 'params' } }, format: 'json'
      expect_status(401)
      expect_json(errors: 'You are not authorized to perform this action')
    end

    it 'should validate uniqueness of email' do
      create(:contact, email: 'test@example.com', user: user)
      request.headers.merge!(authenticated_header_for(user))
      put :update, params: {
        id: contact.id,
        contact: { email: 'test@example.com' }
      }, format: 'json'

      expect_status(422)
      expect_json('errors', { email: ['has already been taken'] })
    end

    it 'should create contact' do
      request.headers.merge!(authenticated_header_for(user))
      put :update, params: {
        id: contact.id,
        contact: { email: 'test@example.com' }
      }, format: 'json'

      contact.reload
      expect_status(200)
      expect(Contact.count).to eq(1)
      expect_json('data', {
        email: 'test@example.com',
        first_name: contact.first_name,
        last_name: contact.last_name,
        user_id: user.id
      })
    end
  end

  context 'DELETE /contacts/1' do
    it 'should return unauthorized access without token' do
      delete :destroy, params: { id: contact.id }, format: 'json'
      expect_status(401)
      expect_json(errors: 'Token is missing in the header request or it is invalid!')
    end

    it 'should return unauthorized access for fake user' do
      request.headers.merge!(authenticated_header_for(fake_user))
      delete :destroy, params: { id: contact.id }, format: 'json'
      expect_status(401)
      expect_json(errors: 'You are not authorized to perform this action')
    end

    it 'should return contact informaton if valid token' do
      request.headers.merge!(authenticated_header_for(user))
      delete :destroy, params: { id: contact.id }, format: 'json'
      expect_status(200)
      expect(Contact.count).to eq(0)
    end
  end
end
