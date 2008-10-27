require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/webpages/display_page.html.haml" do
  include WebpagesHelper
  
  before(:each) do
    assigns[:webpage] = @webpage = stub_model(Webpage)
  end

  it "should render attributes in <p>"
  # do
  #   params[:site] = "foo"
  #   @request.path_parameters[:site => 'foo']
  #   render "/webpages/display_page.html.haml"
  # end
  
end

