require 'swagger_helper'

RSpec.describe Api::V1::RegistrationsController, type: :request do
  let(:valid_user_params) do
    {
      email: Faker::Internet.unique.email,
      password: '123456',
      password_confirmation: '123456',
      role: %w[client admin].sample,
      first_name: 'John',
      last_name: 'Doe',
      username: Faker::Internet.username(specifier: 5..10),
      user_photo: 'path/to/photo.jpg'
    }
  end

  let(:invalid_user_params) do
    {
      email: Faker::Internet.unique.email,
      password: '123456',
      password_confirmation: '123',
      role: %w[client admin].sample,
      first_name: 'John',
      last_name: 'Doe',
      username: 'johndoe',
      user_photo: 'path/to/photo.jpg'
    }
  end

  describe 'User create endpoints' do
    context 'with valid params' do
      it 'creates a new user with a valid token', :show_in_doc do
        post '/api/v1/users', params: { user: valid_user_params }
        expect(response).to have_http_status(:created)
        expect(User.count).to eq(1)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status if one parameter is not valid', :show_in_doc do
        post '/api/v1/users', params: { user: invalid_user_params }
        expect(response).to have_http_status(:unprocessable_entity)
        # Optionally, you can check the response body for more details
        # expect(response.body).to include('Validation failed for...')
      end
    end
  end
end
