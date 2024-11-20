# Set the variant processor to use mini_magick for image processing
Rails.application.config.active_storage.variant_processor = :mini_magick

# Set default URL options for Active Storage
Rails.application.config.after_initialize do
  ActiveStorage::Current.url_options = { host: "localhost", port: 3000 }
end

# Configure allowed inline image variants
Rails.application.config.active_storage.variants_allowed = true
