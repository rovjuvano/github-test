require 'net/http'
require 'nokogiri'

class Scraper
  def initialize(url, style)
    @url = URI.parse(url)
    @class = style
  end

  def list_urls
    body = Net::HTTP.get_response(@url).body
    selector = 'a[href]' + (@class.nil? ? '' : ".#{@class}")
    Nokogiri::HTML(body).css(selector).inject([]) do |urls, tag|
      urls << {
        :url   => clean_url( tag.attr(:href), @url ),
        :title => clean_title(tag.text),
        :raw   => tag.to_s,
      }
    end
  end

  private
    def clean_url(href, root)
      href_escaped = URI::escape(href)
      uri = URI.parse href_escaped
      uri = root.merge(href_escaped) if uri.relative?
      uri.normalize.to_s
    end

    def clean_title(title)
      title.strip
    end
end
