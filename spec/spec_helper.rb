ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'
require 'ffaker'
require 'draper/test/rspec_integration'
require 'factory_girl_rails'
require 'rake'
require 'json_expressions/rspec'
require 'cancan/matchers'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# load the schema every time to enable in-memory sqlite spec runs
silence_stream(STDOUT) { load "#{Rails.root}/db/schema.rb" }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  # focused tests.
  # starting a test with "fit" instead of "it" will result in only that test being run
  config.alias_example_to :fit, focus: true
  config.filter_run focus: true
  config.filter_run_excluding broken: true
  config.run_all_when_everything_filtered = true
  config.infer_spec_type_from_file_location!
  config.infer_base_class_for_anonymous_controllers = false
  config.expose_current_running_example_as :example
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.order = 'random'
  config.color = true

  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) { FactoryGirl.reload }
end
