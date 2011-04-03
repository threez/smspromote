require "net/http"
require "net/https"
require "uri"

module SmsPromote
  class Gateway
    DOMAIN = "gateway.smspromote.de".freeze
    SECURE = "https://#{DOMAIN}"
    INSECURE = "http://#{DOMAIN}"
    
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
      
      response = session do |http|
        request = Net::HTTP::Post.new("/")
        request.body = Gateway.encode_params(options)
        http.request(request)
      end
      
      data = parse_response(response.body)
      message.after_send(data[:code], data[:message_id], data[:cost], data[:count])
      message
    end
    
    # returns the credits left for the gateway
    def credits
      session do |http|
        http.get("/credits/?key=#{@api_key}").body.to_f
      end
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
    
    # returns true if the service should use https
    def secure?
      !!@options[:secure]
    end
    
    # returns true if the messages should contain an orginator
    def originator?
      !!@options[:originator]
    end

    # returns either basic or gold
    def route
      originator? ? :gold : :basic
    end
  
    # returns the service url based on the security options
    def service_url
      URI.parse(secure? ? SECURE : INSECURE)
    end
    
    # returns the encoded params str based on the passed hash
    def self.encode_params(params = {})
      data = []
      params.each do |key, value|
        data << "#{key}=#{URI.escape(value.to_s)}"
      end
      data.join("&")
    end
    
  private
    
    def session # :yield: http
      http = Net::HTTP.new(service_url.host, service_url.port)
      if secure?
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      end
      yield(http)
    end
  end
end
