require 'net/http'
require 'nokogiri'

class Scraper
  def initialize(url, style)
    @url = URI.parse(url)
    @class = style
  end

  def list_urls
    body = Net::HTTP.get_response(@url).body
    selector = @class.nil? ? 'a' : "a.#{@class}"
    Nokogiri::HTML(body).css(selector).inject([]) do |urls, tag|
      urls << {
        :url   => tag.attr(:href),
        :title => tag.text,
        :raw   => tag.to_s,
      }
    end
  end
end
