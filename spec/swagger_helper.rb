require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: '127.0.1:3000/api/v1/'
            }
          }
        }
      ]
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end

require 'swagger_helper'

describe 'API V1', swagger_doc: 'v1/swagger.yaml' do
  path '/users' do
    post 'Creates a user' do
      tags 'Users'
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

  path '/users/{id}' do
    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'User found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 email: { type: :string },
                 role: { type: :string },
                 first_name: { type: :string },
                 last_name: { type: :string },
                 username: { type: :string },
                 user_photo: { type: :string }
               },
               required: %w[id email role username]

        let(:id) do
          User.create(email: 'fitzgeraldnsong@gmail.com', password: 'password123', password_confirmation: 'password123',
                      role: 'client', first_name: 'Fitzgerald', last_name: 'Nsong', username: 'fitznsong', user_photo: 'path/to/photo.jpg').id
        end
        run_test!
      end

      response '404', 'User not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/users/{id}' do
    put 'Updates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
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

      response '404', 'User not updated!' do
        run_test!
      end

      response '200', 'User updated' do
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

  path '/users/{id}' do
    delete 'Deletes a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '404', 'User not deleted!' do
        run_test!
      end

      response '200', 'User deleted' do
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

  path '/users' do
    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'Users found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 email: { type: :string },
                 role: { type: :string },
                 first_name: { type: :string },
                 last_name: { type: :string },
                 username: { type: :string },
                 user_photo: { type: :string }
               },
               required: %w[id email role username]

        run_test!
      end
    end
  end
end
