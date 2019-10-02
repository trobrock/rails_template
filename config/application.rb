# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.level = :info if Rails.env.production? || Rails.env.staging?

    # Use default logging formatter so that PID and timestamp are not suppressed.
    config.log_formatter = ::Logger::Formatter.new
    logger.formatter     = config.log_formatter

    config.logger = ActiveSupport::TaggedLogging.new(logger)

    config.lograge.enabled = true
  end
end
