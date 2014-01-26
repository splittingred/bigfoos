ActiveRecord::Base.logger = nil
cur = Dir.pwd+'/db/fixtures/load.rb'
Dir["#{File.expand_path('../', __FILE__)}/db/fixtures/**/*.rb"].each {|f| require f unless f == cur }