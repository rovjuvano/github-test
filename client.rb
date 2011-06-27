require 'net/http'
require 'json'

SERVER = URI.parse 'http://localhost:9292/'
PATH = 'a.b?url=http://wimp.com/'
#PATH = 'a.gb4?url=http://www.google.com/'
#PATH = 'a.small?url=http://www.yahoo.com/'

response = Net::HTTP.get_response(SERVER.merge(PATH))

if response['Content-Type'] != 'application/json'
  puts response.body
  exit 1
end

JSON.parse(response.body).each do |url|
  puts "  url: #{url['url']}"
  puts "title: #{url['title']}"
  #puts "raw: #{url['raw']}"
  puts '-' * 80
end
