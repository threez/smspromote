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
