require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module BigFoos
  class Application < Rails::Application
    config.time_zone = 'Eastern Time (US & Canada)'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # don't generate RSpec tests for views and helpers
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :fabrication

      g.view_specs false
      g.helper_specs false
    end

    config.autoload_paths += Dir[Rails.root.join('lib')]
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.autoload_paths += Dir[Rails.root.join('app', 'models')]
    config.autoload_paths += Dir[Rails.root.join('app', 'interactors')]

    config.assets.intialize_on_precompile = false
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    config.assets.precompile += ['controllers/*.css']
  end
end

I18n.enforce_available_locales = false
