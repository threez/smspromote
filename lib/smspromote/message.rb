module SmsPromote
  class Message
    attr_reader :type, :reference, :recipient, :body,
                :code, :message_id, :cost, :count, :send_time
    
    # creates a new message object with an recipient and a message body
    # recipient:: [String] the number to send this message
    # body:: [String] the body of the message
    def initialize(recipient, body)
      @recipient = recipient
      @body = body
      @type = :default
    end
    
    # returns true if the message is valid, false otherwise
    def valid?
      !@body.nil? && !@recipient.nil?
    end
    
    # returns true if the sms has to be send in multiple parts
    def multipart?
      @body.length > 160
    end
    
    # returns true if the message was send
    def send?
      @send
    end
    
    # returns true if the message was delivered, false otherwise
    def delivered?
      @code == 100
    end
    
    # encode the the content of the body according to the interface spec
    def encode!(from = "UTF-8", to = "ISO-8859-1")
      # ruby 1.9 and higher
      if "".respond_to?(:encode) && "".respond_to?(:force_encoding)
        @body = @body.force_encoding(from).encode(to)
      else # ruby 1.8
        require "iconv"
        @body = Iconv.iconv(to, from, @body).first
      end
    end
    
    # sets the message information after the message has been send
    # code:: [Fixnum] the message code (e.g. 100)
    # message_id:: [String] the message id string 
    # cost:: [Float] the cost for sending the message
    # count:: [Fixnum] the count of smsparts that have been sended
    def after_send(code, message_id, cost, count)
      @send_time = Time.now
      @send = true
      @code = code
      @message_id = message_id
      @cost = cost
      @count = count
    end
  end
end
