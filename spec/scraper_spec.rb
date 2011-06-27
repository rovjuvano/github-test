require 'spec_helper'

describe "scraper-app" do
  it "should run tests" do
    true
  end

  it "should get root URL" do
    get '/'
    last_response.should be_ok
  end

  it "should return JSON" do
    get '/'
    last_response.headers['Content-Type'].should == 'application/json'
    JSON.parse(last_response.body)
  end

  it "should return array of URLs" do
    get '/'
    urls = JSON.parse(last_response.body)
    urls.length.should > 0
    urls.each do |url|
      url['url'].should_not be_nil
    end
  end
end
