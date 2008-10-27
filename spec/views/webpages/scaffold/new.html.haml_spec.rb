require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/webpages/scaffold/new.html.haml" do
  include WebpagesHelper
  
  before(:each) do
    assigns[:webpage] = stub_model(Webpage,
      :new_record? => true
    )
  end

  it "should render new form" do
    render "/webpages/scaffold/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", webpages_path) do
    end
  end
end


