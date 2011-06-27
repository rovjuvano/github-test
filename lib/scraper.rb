require 'net/http'
require 'nokogiri'

class Scraper
  def initialize(url)
    @url = URI.parse(url)
  end

  def list_urls
    body = Net::HTTP.get_response(@url).body
    Nokogiri::HTML(body).css('a').inject([]) do |urls, tag|
      urls << {
        :url   => tag.attr(:href),
        :title => tag.text,
        :raw   => tag.to_s,
      }
    end
  end
end
