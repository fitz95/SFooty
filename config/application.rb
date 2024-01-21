require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SFooty
  class Application < Rails::Application
    config.api_only = true

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.session_store :cookie_store, key: 'sfooty_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
    config.assets.enabled = false

    config.action_dispatch.default_headers = {
      'Content-Security-Policy' => {
        'default-src' => "'self'",
        'connect-src' => "'self' http://localhost:3000 ws://localhost:3000 http://localhost:3001 ws://localhost:3001",
        'script-src' => "'self' 'unsafe-inline' 'unsafe-eval'", # Add more directives as needed
        'style-src' => "'self' 'unsafe-inline'",
      }
    }
    


    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end

require_relative '../lib/rswag_csp_patch'