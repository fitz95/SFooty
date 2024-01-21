require 'swagger_helper'

RSpec.describe 'Registrations API', type: :request do
  let(:user) do
    {
      password_confirmation: 'password123',
      email: 'user@example.com',
      password: 'password123',
      role: 'client',
      first_name: 'John',
      last_name: 'Doe',
      username: 'johndoe',
      user_photo: 'path/to/photo.jpg'
    }
  end

  path '/v1/users' do
    post 'Creates a new user' do
      tags 'registrations'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          password_confirmation: { type: :string, required: true, description: 'User password confirmation' },
          email: { type: :string, required: true, description: 'User email' },
          password: { type: :string, required: true, description: 'User password' },
          role: { type: :string, required: true, default: 'client', description: 'User role' },
          first_name: { type: :string, default: 'name', description: 'User first name' },
          last_name: { type: :string, default: 'name', description: 'User last name' },
          username: { type: :string, required: true, default: 'name', description: 'User username' },
          user_photo: { type: :string, default: 'name', description: 'User profile photo' }
        },
        required: %w[password_confirmation email password role username]
      }

      response '404', 'User not created!' do
        run_test!
      end

      response '201', 'User created' do
        consumes 'application/json'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :integer },
            email: { type: :string },
            role: { type: :string },
            first_name: { type: :string },
            last_name: { type: :string },
            username: { type: :string },
            user_photo: { type: :string }
          }
        }
        run_test!
      end
    end
  end
end
