source "https://rubygems.org"

gem "rails", "~> 7.2.1", ">= 7.2.1.1" # Rails
gem "haml-rails" # Haml for templating
gem "sprockets-rails" # Asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sqlite3", ">= 1.4" # Database
gem "puma", ">= 5.0" # Puma web server [https://github.com/puma/puma]
gem "importmap-rails" # JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "turbo-rails" # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "stimulus-rails" # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "tzinfo-data", platforms: %i[ windows jruby ] # Timezone data for TZInfo
gem "bootsnap", require: false # Reduces boot times through caching; required in config/boot.rb
gem "devise" # Authentication
gem "rails_admin" # Admin interface
gem "cssbundling-rails" # CSS Bundling
gem "omniauth" # Authentication
gem "omniauth-google-oauth2" # Google OAuth2
gem "sassc-rails" # SASSC for Rails
gem "ostruct" # OpenStruct
gem "image_processing" # Image processing
gem "mini_magick" # MiniMagick for image processing
gem "kaminari" # Pagination
gem 'bootstrap5-kaminari-views' # Bootstrap 5 Kaminari views
gem "mercadopago-sdk" # Mercado Pago SDK
gem "rack-cors" # Rack CORS

group :test do
end

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude" # Debug
  gem "brakeman", require: false # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "rubocop-rails-omakase", require: false # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rspec-rails" # Testing
  gem 'shoulda-matchers' # Testing helpers
  gem 'factory_bot_rails' # Testing factories
  gem 'faker' # Testing data
end

group :development do
  gem "web-console" # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "pry-byebug" # Debugging with Pry
  gem "html2haml" # Convert HTML to Haml
  gem "rest-client" # REST Client
end
