module SmsPromote
  VERSION = "0.0.3"
end

gem 'rest-client', '>= 1.6.0'

require 'rest_client'

require 'smspromote/message'
require 'smspromote/gateway'
require 'smspromote/encoding'
