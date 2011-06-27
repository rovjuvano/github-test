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
set :default_url, 'http://example.org'

SAMPLE_PAGE1 = File.dirname(__FILE__) + '/sample_page1.html'
SAMPLE_PAGE2 = File.dirname(__FILE__) + '/sample_page2.html'
FakeWeb.register_uri(:get, %r{example.org}, :body => open(SAMPLE_PAGE1))
FakeWeb.register_uri(:get, %r{example.com}, :body => open(SAMPLE_PAGE2))
