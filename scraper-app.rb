require 'sinatra'
require 'json'
require './lib/scraper'

get '/' do
  redirect to('/a')
end

get %r{/a(?:\.(.+))?} do |style|
  scraper = Scraper.new 'http://wimp.com/', style
  urls = scraper.list_urls
  content_type :json
  urls.to_json
end
