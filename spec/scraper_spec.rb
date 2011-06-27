require 'spec_helper'

describe "scraper-app" do
  def get_links(path)
    get path
    follow_redirect! if last_response.redirect?
    JSON.parse(last_response.body)
  end

  it "should run tests" do
    true
  end

  it "should get root URL" do
    get '/'
    last_response.should be_redirect
  end

  it "should return JSON" do
    get '/'
    follow_redirect!
    last_response.headers['Content-Type'].should == 'application/json'
    JSON.parse(last_response.body)
  end

  it "should return array of URLs" do
    urls = get_links '/'
    urls = JSON.parse(last_response.body)
    urls.length.should > 0
    urls.each do |url|
      url['url'].should_not be_nil
    end
  end

  it "should return URLs for anchor tags" do
    urls = get_links '/'
    urls.length.should >= 4
    urls[0]['url'].should =~ %r{/a$}
    urls[1]['url'].should =~ %r{/a\.a$}
    urls[2]['url'].should =~ %r{/a\.b$}
    urls[3]['url'].should =~ %r{/a\.a\+b$}
  end

  it "should include URL, title, and raw HTML" do
    url = get_links('/')[0]
    url['url'].should == 'http://localhost/a'
    url['title'].should == 'a[href]'
    url['raw'].should == '<a href="http://localhost/a">a[href]</a>'
  end

  it "should filter based on CSS class" do
    urls = get_links '/a.b'
    urls.length.should == 2
    urls[0]['title'].should == 'a[href].b'
  end

  it "should accept url parameter" do
    urls = get_links '/a?url=http://www.example.com/'
    urls.length.should == 2
    urls[0]['title'].should == 'example link 1'
  end

  it "should return error if somethings goes wrong" do
     get '/a?url=https://www.google.com/'
     last_response.should_not be_ok
     last_response.body.should =~ /something bad happened/i
  end

  it "should convert relative URLs into absolute" do
    url = get_links('/a.rel')[0]
    url['url'].should == 'http://example.org/rel'
  end

  it "should escape unsafe characters in URLs" do
    url = get_links('/a.unsafe')[0]
    url['url'].should =~ /%5Eunsafe%5E/i
  end

  it "should strip surrounding whitespace from title" do
    url = get_links('/a.ws')[0]
    url['title'].should =~ /^[^\s].*[^\s]$/
  end
end
