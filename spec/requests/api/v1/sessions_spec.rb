require 'swagger_helper'

RSpec.describe 'Api::V1::Sessions', type: :request do
  let(:user) do
    User.create!(
      email: Faker::Internet.unique.email,
      password: '123456',
      password_confirmation: '123456',
      role: %w[client admin].sample,
      first_name: 'John',
      last_name: 'Doe',
      username: Faker::Internet.username(specifier: 5..10),
      user_photo: 'path/to/photo.jpg'
    )
  end

  describe 'User login and logout endpoints' do
    it 'returns a user with a valid token', :show_in_doc do
      post '/api/v1/users/sign_in', params: { user: { login: user.email, password: user.password } }
      expect(response).to have_http_status(:created)
    end

    it 'returns an error message if one parameter is not valid', :show_in_doc do
      post '/api/v1/users/sign_in', params: { user: { login: user.email, password: '1234567' } }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns a successful logout message', :show_in_doc do
      post '/api/v1/users/sign_in', params: { user: { login: user.email, password: user.password } }
      token = response.headers['Authorization']
      delete '/api/v1/users/sign_out', headers: { 'Authorization' => token }
      expect(response).to have_http_status(:ok)
    end

    it 'returns an error message if the token is not valid', :show_in_doc do
      post '/api/v1/users/sign_in', params: { user: { login: user.email, password: user.password } }
      token = nil
      delete '/api/v1/users/sign_out', headers: { 'Authorization' => token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
