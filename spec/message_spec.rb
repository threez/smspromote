require File.join(File.dirname(__FILE__), 'spec_helper')

describe SmsPromote::Message do
  it "should be possible to create a simple message" do
    message = SmsPromote::Message.new('004917011122233', 'Hello World')
    message.valid?.should == true
    message.type.should == :default
    message.reference.should == nil
  end
  
  it "should correctly determine multipart sms" do
    message = SmsPromote::Message.new('004917011122233', 'Hello World')
    message.multipart?.should == false
    message = SmsPromote::Message.new('004917011122233', 'Hello World' * 50)
    message.multipart?.should == true
  end
end