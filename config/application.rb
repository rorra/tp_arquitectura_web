require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you"ve limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TpArquitecturaWeb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Buenos Aires"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don"t generate system test files.
    config.generators.system_tests = nil

    # Locale setup
    config.i18n.default_locale = :es
    config.i18n.available_locales = [:es, :en]

    # Locale load path
    config.i18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.{rb,yml}")]

    # CORS configuration
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "http://localhost:3000" # Allow your front-end origin
        resource "*",
                 headers: :any,
                 methods: [:get, :post, :put, :delete, :options],
                 expose: ["Authorization"]
      end
    end
  end
end
