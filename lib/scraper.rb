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
        :url   => clean_url( tag.attr(:href), @url ),
        :title => tag.text,
        :raw   => tag.to_s,
      }
    end
  end

  private
    def clean_url(href, root)
      uri = URI.parse href
      uri = root.merge(href) if uri.relative?
      uri.normalize.to_s
    end
end
