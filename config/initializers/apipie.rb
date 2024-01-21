Apipie.configure do |config|
  config.app_name                = "SFooty"
  config.api_base_url            = "/api"
  config.copyright               = "&copy; 2023 Fitz Gerald"
  config.doc_base_url            = "/api/docs"
  config.show_all_examples       = true
  config.app_info["1.0"]         = "The Sfooty Api app collects league statistics and provides a platform for users to interact with each other"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
