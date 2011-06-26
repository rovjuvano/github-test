require 'rack/test'
require_relative '../scraper-app'

set :environment, :test

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  Sinatra::Application
end
