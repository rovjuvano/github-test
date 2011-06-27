require 'sinatra'
require 'json'

get '/' do
  content_type :json
  [ :url => 'foo' ].to_json
end
