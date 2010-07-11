$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require "smspromote"

require "rubygems"
require "spec"

API_KEY = SmsPromote::Gateway.read_api_key_from_file