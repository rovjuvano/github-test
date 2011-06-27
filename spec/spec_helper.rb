require 'rack/test'
require 'fakeweb'
require_relative '../scraper-app'

set :environment, :test

RSpec.configure do |config|
  config.include Rack::Test::Methods
end

def app
  Sinatra::Application
end

FakeWeb.allow_net_connect = false

SAMPLE_PAGE1 = File.dirname(__FILE__) + '/sample_page1.html'
FakeWeb.register_uri(:get, %r{wimp.com}, :body => open(SAMPLE_PAGE1))
