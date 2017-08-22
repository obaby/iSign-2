require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  context 'GET /user/:id' do
    it 'should return unauthorized access without token' do
      fake = create(:fake_user)
      get :show, params: { id: fake.id }, format: 'json'

      expect_status(401)
      expect_json(
        errors: 'Token is missing in the header request or it is invalid!'
      )
    end

    it 'should return unauthorized access with fake user' do
      user = create(:user)
      fake = create(:fake_user)
      request.headers.merge! authenticated_header_for(user)
      get :show, params: { id: fake.id }, format: 'json'

      expect_status(401)
      expect_json(
        errors: 'You are not authorized to perform this action'
      )
    end

    it 'should return user payload with valid credentials' do
      user = create(:user)
      request.headers.merge! authenticated_header_for(user)
      get :show, params: { id: user.id }, format: 'json'

      expect_status(200)
      expect_json(
        'data',
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        phone_number: user.phone_number
      )
    end
  end

  context 'POST /users' do
    it 'should require user param' do
      post :create, params: {}, format: 'json'

      expect_status(422)
      expect_json(errors: 'param is missing or the value is empty: user')
      expect_json_keys([:errors, :backtrace, :exception])
    end

    it 'should validate presence of password, email, first_name, last_name, phone_number' do
      post :create, params: { user: { fake: 'params' } }, format: 'json'

      expect_status(422)
      expect_json('errors', password: ["can't be blank"], email: ["can't be blank"], first_name: ["can't be blank"], last_name: ["can't be blank"], phone_number: ["can't be blank"])
    end

    it 'should validate uniqueness of email' do
      post :create, params: { user: {
        email: user.email,
        password: user.password,
        first_name: user.first_name,
        last_name: user.last_name,
        phone_number: user.phone_number
      }}, format: 'json'

      expect_status(422)
      expect_json('errors', email: ['has already been taken'])
    end

    it 'should create new user' do
      u = build(:user)
      post :create, params: {
        user: {
          email: u.email,
          password: u.password,
          first_name: u.first_name,
          last_name: u.last_name,
          phone_number: u.phone_number
        }
      }

      expect_status(200)
      expect_json(
        'data',
        email: u.email,
        first_name: u.first_name,
        last_name: u.last_name,
        phone_number: u.phone_number
      )
    end
  end
end
