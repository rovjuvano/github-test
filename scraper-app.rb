require 'sinatra'
require 'json'
require './lib/scraper'

get '/' do
  scraper = Scraper.new 'http://wimp.com/'
  urls = scraper.list_urls
  content_type :json
  urls.to_json
end
