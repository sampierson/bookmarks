require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/webpages/scaffold/show.html.haml" do
  include WebpagesHelper
  
  before(:each) do
    assigns[:webpage] = @webpage = stub_model(Webpage)
  end

  it "should render attributes in <p>" do
    render "/webpages/scaffold/show.html.haml"
  end
end

