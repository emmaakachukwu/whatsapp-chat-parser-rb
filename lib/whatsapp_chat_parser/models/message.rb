module WhatsappChatParser
  module Models
    class Message
      attr_accessor :timestamp, :author, :message, :type

      def initialize(timestamp, author, message, type)
        @timestamp = timestamp
        @author = author
        @message = message
        @type = type
      end
    end
  end
end
