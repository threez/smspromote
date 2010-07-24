require File.join(File.dirname(__FILE__), 'spec_helper')

describe SmsPromote::Gateway do
  it "should be possible to create a sms gateway" do
    gateway = SmsPromote::Gateway.new API_KEY
    gateway.service_url.should =~ /http:/
    gateway.route.should == :basic
    gateway = SmsPromote::Gateway.new API_KEY, :secure => true
    gateway.service_url.should =~ /https:/
    gateway.route.should == :basic
    gateway = SmsPromote::Gateway.new API_KEY, :originator => "0049170111222333"
    gateway.service_url.should =~ /http:/
    gateway.route.should == :gold
    gateway.debug?.should == false
    gateway = SmsPromote::Gateway.new API_KEY, :debug => true
    gateway.debug?.should == true
  end
  
  it "should parse responses correctly" do
    gateway = SmsPromote::Gateway.new API_KEY, :debug => true
    data = gateway.parse_response("100\n123456789\n0\n1\n")
    data[:code].should == 100
    data[:message_id].should == "123456789"
    data[:cost].should == 0
    data[:count].should == 1
  end
  
  it "should be possible to send a simple message debug" do
    gateway = SmsPromote::Gateway.new API_KEY, :debug => true
    message = SmsPromote::Message.new('001231231231123', 'Hello World')
    gateway.send_message(message)
    message.delivered?.should == true
  end
  
  it "should be possible to return the credits left" do
    gateway = SmsPromote::Gateway.new API_KEY, :debug => true
    gateway.credits.should >= 0
  end
end