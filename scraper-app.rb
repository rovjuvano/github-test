require 'sinatra'
require 'json'
require './lib/scraper'

get '/' do
  redirect to('/a')
end

get %r{/a(?:\.(.+))?} do |style|
  begin
    scraper = Scraper.new params[:url] || settings.default_url, style
    urls = scraper.list_urls
  rescue
    return 500, 'Something bad happened'
  end
  content_type :json
  urls.to_json
end
