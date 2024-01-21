require 'swagger_helper'

RSpec.describe 'Api::V1::Users', type: :request do
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

  before(:each) do
    post '/api/v1/users/sign_in', params: { user: { login: user.email, password: user.password } }
    @token = response.headers['Authorization']
  end

  describe 'User index endpoints' do
    it 'returns all users', :show_in_doc do
      get '/api/v1/users/', headers: { 'Authorization' => @token }
      expect(response).to have_http_status(:ok)
    end

    it 'returns an error message if the token is not valid', :show_in_doc do
      token = nil
      get '/api/v1/users/', headers: { 'Authorization' => token }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'User show endpoints' do
    it 'returns a user', :show_in_doc do
      get "/api/v1/users/#{user.id}", headers: { 'Authorization' => @token }
      expect(response).to have_http_status(:ok)
    end

    it 'returns an error message if the token is not valid', :show_in_doc do
      token = nil
      get "/api/v1/users/#{user.id}", headers: { 'Authorization' => token }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'User destroy endpoints' do
    it 'returns a successful message if the user is admin', :show_in_doc do
      user.update(role: 'admin')
      delete "/api/v1/users/#{user.id}", headers: { 'Authorization' => @token }
      expect(response).to have_http_status(:ok)
    end

    it 'returns an error message if the token is not valid', :show_in_doc do
      token = nil
      delete "/api/v1/users/#{user.id}", headers: { 'Authorization' => token }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
