require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/webpages/scaffold/index.html.haml" do
  include WebpagesHelper
  
  before(:each) do
    assigns[:webpages] = [
      stub_model(Webpage),
      stub_model(Webpage)
    ]
  end

  it "should render list of webpages" do
    render "/webpages/scaffold/index.html.haml"
  end
  
end

