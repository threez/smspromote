module SmsPromote
  VERSION = "0.0.1"
end

begin
  require 'rest_client'
rescue LoadError
  require 'rubygems'
  require 'rest_client'
end

require 'smspromote/message'
require 'smspromote/gateway'
