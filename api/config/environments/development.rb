# frozen_string_literal: true

Rails.application.configure do
  # Settings specified here will take precedence over those in
  # config/application.rb.

  # Do not eager load code on boot.
  config.eager_load = false
  config.active_storage.service = :local

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Do not send actual e-mails in development mode. Use the Letter Opener gem
  # to save "sent" e-mails in HTML files within tmp/letter_opener
  config.action_mailer.delivery_method = :test
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Host for links sent via e-mail by Action Mailer
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # If using Docker for development, allow the host to see the detailed exceptions provided by the better-errors gem
  BetterErrors::Middleware.allow_ip! "172.0.0.0/8"
end
