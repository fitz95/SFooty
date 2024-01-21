require 'swagger_helper'

describe 'Users API' do
  path '/v1/users/password' do
    put 'Update user password' do
      tags 'passwords'
      consumes 'application/x-www-form-urlencoded'
      parameter name: :user, in: :formData, type: :object, properties: {
        password_confirmation: { type: :string, required: true, description: 'User password confirmation' },
        email: { type: :string, required: true, description: 'User email' },
        password: { type: :string, required: true, description: 'User password' }
      }

      response '404', 'Password not updated!' do
        run_test!
      end
    end
  end

  path '/v1/users' do
    post 'Create a new user' do
      tags 'registrations'
      consumes 'application/x-www-form-urlencoded'
      parameter name: :user, in: :formData, type: :object, properties: {
        password_confirmation: { type: :string, required: true, description: 'User password confirmation' },
        email: { type: :string, required: true, description: 'User email' },
        password: { type: :string, required: true, description: 'User password' },
        role: { type: :string, required: true, default: 'client', description: 'User role' },
        first_name: { type: :string, default: 'name', description: 'User first name' },
        last_name: { type: :string, default: 'name', description: 'User last name' },
        username: { type: :string, required: true, default: 'name', description: 'User username' },
        user_photo: { type: :string, default: 'name', description: 'User profile photo' }
      }

      response '404', 'User not created!' do
        run_test!
      end
    end

    get 'Get all users' do
      tags 'users'
      consumes 'application/x-www-form-urlencoded'

      response '404', 'Users not found!' do
        run_test!
      end
    end
  end

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

  path '/v1/users/{id}' do
    get 'Get user with id' do
      tags 'users'
      consumes 'application/x-www-form-urlencoded'
      parameter name: :id, in: :path, type: :number, required: true, description: 'ID of the requested user'

      response '404', 'User not found!' do
        run_test!
      end
    end

    delete 'Delete user by id' do
      tags 'users'
      consumes 'application/x-www-form-urlencoded'
      parameter name: :id, in: :path, type: :number, required: true, description: 'ID of the requested user'

      response '404', 'User not found!' do
        run_test!
      end
    end
  end
end