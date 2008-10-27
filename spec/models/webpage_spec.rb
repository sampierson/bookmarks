require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Webpage do
  before(:each) do
    @valid_attributes = {
      :url => "http://google.com"
    }
  end

  it "should create a new instance given valid attributes" do
    Webpage.create!(@valid_attributes)
  end
  
  it "should fail to create a webpage when url is not supplied" do
    Webpage.create(@valid_attributes.merge({:url => nil})).should have(1).error_on(:url)
  end
  
  it "can have columns" do
    # w = Webpage.find_by_url('webpage_1')
    w = Webpage.create!(@valid_attributes)
    w.should_not be_nil
    c1 = mock_model(Column)
    c2 = mock_model(Column)
    c1.should_receive(:[]=).with("webpage_id", w.id)
    c1.should_receive(:save)
    c2.should_receive(:[]=).with("webpage_id", w.id)
    c2.should_receive(:save)
    w.columns << c1
    w.columns << c2
  end
  
end
