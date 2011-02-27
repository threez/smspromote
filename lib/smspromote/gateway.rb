require "net/http"
require "uri"

module SmsPromote
  class Gateway
    SECURE = "https://gateway.smspromote.de"
    INSECURE = "http://gateway.smspromote.de"
    
    # returns the api key as string. The api key will be read 
    # from the ".smspromote.key" file from the home directroy of
    # the current user
    def self.read_api_key_from_file
      File.read("#{ENV['HOME']}/.smspromote.key").chomp
    end
    
    # create a new gateway using the passed api_key and options
    # api_key:: [String] yourt api key (e.g. "KAJSHkjhlskfl32jh24")
    # options:: a hash of options
    #   :secure (true/false) # use ssl or not
    #   :originator (string) # sender address
    #   :debug (true/false)  # use the dummy service
    def initialize(api_key, options = {})
      @api_key = api_key
      @options = {
        :secure => false
      }.merge(options)
    end
    
    # send message using the gateway defaults
    def send_message(message)
      options = {
        :key => @api_key, 
        :to => message.recipient,
        :message => message.body, 
        :route => route,
        :concat => message.multipart? ? 1 : 0,
        :debug => debug? ? 1 : 0,
        :message_id => 1,
        :cost => 1,
        :count => 1
      }
      
      # use oroginator if gold route was used
      if route == :gold
        options[:from] = @options[:originator]
      end
      
      response = Net::HTTP.post_form(URI.parse(service_url + "/"), options)
      data = parse_response(response.body)
      message.after_send(data[:code], data[:message_id], data[:cost], data[:count])
      message
    end
    
    # returns the credits left for the gateway
    def credits
      url = URI.parse(service_url + "/credits/?key=#{@api_key}")
      Net::HTTP.get(url).to_f
    end
    
    # returns the response message hash based on the body data
    def parse_response(body)
      lines = body.split(/\n/)
      {
        :code => lines[0].to_i,
        :message_id => lines[1],
        :cost => (lines[2] || "0").to_f,
        :count => (lines[3] || "0").to_i
      }
    end

    # returns true if the message sending is a dummy operation
    def debug?
      !!@options[:debug]
    end

    # returns either basic or gold
    def route
      @options[:originator] ? :gold : :basic
    end
  
    # returns the service url based on the security options
    def service_url
      @options[:secure] ? SECURE : INSECURE
    end
  end
end
