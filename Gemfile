source 'https://rubygems.org'

#ruby '2.0.0'

gem 'active_model_serializers', github: 'rails-api/active_model_serializers', branch: 'master'
gem 'draper', '~> 1.3' # for view decorators
gem 'foreman'
gem 'hashie', '~> 3.3' # hashes on steroids
gem 'has_scope', '~> 0.5' # query parameter filtering for views
gem 'interactor-rails', '~> 2.0' # feature rich service classes
gem 'json', '~> 1.8'
gem 'mysql2', '0.3.14'
gem 'rails', '4.1.5'
gem 'settingslogic', '~> 2.0'
gem 'sucker_punch', '~> 1.0'
gem 'versionist', '~> 1.4.0' # api versioning
gem 'workflow', '~> 1.1'

# deployment/logging
gem 'dotenv-rails', '~> 0.11'
gem 'rack-attack', '~> 2.3'
gem 'rack-protection', '~> 1.5'

# auth/security
gem 'devise', '~> 3.0.1'
gem 'devise-encryptable', '~> 0.1.2'
gem 'cancan', '~> 1.6.10'
gem 'cancan_strong_parameters', '~> 0.4'
gem 'role_model', '~> 0.8.1'
gem 'omniauth', '>= 1.0.0'
gem 'omniauth-google-oauth2', '0.2.6'

# rails stuff
gem 'jquery-rails'
gem 'font-awesome-sass-rails'
gem 'jquery-ui-rails'
gem 'haml-rails'
gem 'bootstrap_form'
gem 'bootstrap-sass', '~> 3.0.3.0'
gem 'kaminari', '>= 0.14.0'
gem 'kaminari-bootstrap', '~> 3.0.1'
gem 'hashugar', '~> 0.0.6', github: 'alex-klepa/hashugar'
gem 'seed-fu', github: 'mbleigh/seed-fu'
gem 'gravtastic'

# asset pipeline
group :assets do
  gem 'sass-rails', '>= 3.2'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.0.0'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.3.20', require: false
end

group :production do
  gem 'rails_12factor'
  gem 'pg'
  gem 'unicorn'
  gem 'unicorn-rails', '~> 1.1.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-livereload'
  gem 'guard-rspec', '~> 4.0.3'
  gem 'quiet_assets'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
end

group :test do
  gem 'database_cleaner', '~> 1.3'
  gem 'sqlite3',                          :platform => [:ruby, :mswin, :mingw]
  gem 'jdbc-sqlite3',                     :platform => :jruby
  gem 'activerecord-jdbcsqlite3-adapter', :platform => :jruby
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'json_expressions', '~> 0.8'
  gem 'spring', '~> 1.1'
  gem 'spring-commands-rspec', '~> 1.0'
end

group :development, :test do
  gem 'factory_girl_rails', require: false
  gem 'ffaker'
  gem 'thin'
  gem 'fabrication'
  gem 'awesome_print'
  gem 'rspec-rails', '~> 2.0'
  gem 'capybara'
  gem 'coveralls', require: false
  gem 'pry-rails'
  gem 'pry-debugger'
  gem 'yard'
  gem 'yard-rspec'
end
