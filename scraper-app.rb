require 'sinatra'
require 'json'

get '/' do
  content_type :json
  [].to_json
end
