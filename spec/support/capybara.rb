require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.configure do |config|
  config.app_host    = ENV['TEST_URL'] || 'http://127.0.0.1:3000'
  config.server_port = ENV['TEST_SERVER_PORT'] || 3000
  config.ignore_hidden_elements = false
  config.default_driver = ENV['TEST_BROWSER_DRIVER'] || :poltergeist
end

RSpec.configure do |config|
  config.include Capybara::DSL
end
