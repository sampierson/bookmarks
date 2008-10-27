require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "/webpages/scaffold/edit.html.haml" do
  include WebpagesHelper
  
  before(:each) do
    assigns[:webpage] = @webpage = stub_model(Webpage,
      :new_record? => false
    )
  end

  it "should render edit form" do
    render "/webpages/scaffold/edit.html.haml"
    
    response.should have_tag("form[action=#{webpage_path(@webpage)}][method=post]") do
    end
  end
end


