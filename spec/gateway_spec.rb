require File.join(File.dirname(__FILE__), 'spec_helper')

describe SmsPromote::Gateway do
  it "should be possible to create a sms gateway" do
    gateway = SmsPromote::Gateway.new API_KEY
    gateway.service_url.to_s.should =~ /http:/
    gateway.route.should == :basic
    gateway = SmsPromote::Gateway.new API_KEY, :secure => true
    gateway.service_url.to_s.should =~ /https:/
    gateway.originator?.should be_false
    gateway.route.should == :basic
    gateway = SmsPromote::Gateway.new API_KEY, :originator => "0049170111222333"
    gateway.originator?.should be_true
    gateway.service_url.to_s.should =~ /http:/
    gateway.route.should == :gold
    gateway.debug?.should be_false
    gateway = SmsPromote::Gateway.new API_KEY, :debug => true
    gateway.debug?.should be_true
  end
  
  it "should parse responses correctly" do
    gateway = SmsPromote::Gateway.new API_KEY, :debug => true
    data = gateway.parse_response("100\n123456789\n0\n1\n")
    data[:code].should == 100
    data[:message_id].should == "123456789"
    data[:cost].should == 0
    data[:count].should == 1
  end
  
  it "should be possible to send a simple debug message" do
    gateway = SmsPromote::Gateway.new API_KEY, :debug => true
    message = SmsPromote::Message.new('001231231231123', 'Hello World')
    gateway.send_message(message)
    message.message_id.should_not == nil
    message.delivered?.should be_true
  end
  
  it "should be possible to send a simple debug message securly" do
    gateway = SmsPromote::Gateway.new API_KEY, :debug => true, :secure => true
    message = SmsPromote::Message.new('001231231231123', 'Hello World')
    gateway.send_message(message)
    message.message_id.should_not == nil
    message.delivered?.should be_true
  end
  
  it "should be possible to return the credits left" do
    gateway = SmsPromote::Gateway.new API_KEY, :debug => true
    gateway.credits.should >= 0
  end
  
  it "should be possible to return the credits left securly" do
    gateway = SmsPromote::Gateway.new API_KEY, :debug => true, :secure => true
    gateway.secure?.should be_true
    gateway.credits.should >= 0
  end
  
  it "should encode the params according to the gateway spec" do
    SmsPromote::Gateway.encode_params(
      :message => txt_file("iso-8859-1")
    ).should == "message=a%20-%20%E4%0Ao%20-%20%F6%0Au" \
      "%20-%20%FC%0AA%20-%20%C4%0AO%20-%20%D6%0AU%20-%20%DC%0As%20-%20%DF"
  end
end