require File.join(File.dirname(__FILE__), 'spec_helper')

describe SmsPromote::Encoding do
  it "should be possible to encode utf-8 characters to gsm7" do
    input = "\342\202\254a\303\244o\303\266u\303\274s\303\237A\303\204O\303\226U\303\234"
    SmsPromote::Encoding.to_gsm(input).should == "\eea{o|u~s\036A[O\\U^"
    SmsPromote::Encoding.from_gsm(SmsPromote::Encoding.to_gsm(input)).should == input
  end
end