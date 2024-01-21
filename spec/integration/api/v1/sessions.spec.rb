
require 'swagger_helper'

describe 'Sessions API' do
  path '/v1/users/sign_in' do
    post 'Sign in user' do
      tags 'sessions'
      consumes 'application/x-www-form-urlencoded'
      parameter name: :user, in: :formData, type: :object, properties: {
        email: { type: :string, required: true, description: 'User email or username' },
        password: { type: :string, required: true, description: 'User password' }
      }

      response '401', 'Invalid email or password' do
        run_test!
      end

      description 'Sign in with email or username and password'
    end
  end

  path '/v1/users/sign_out' do
    delete 'Sign out user' do
      tags 'sessions'
      consumes 'application/x-www-form-urlencoded'

      response '422', 'Invalid token' do
        run_test!
      end
    end
  end
end