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
end
