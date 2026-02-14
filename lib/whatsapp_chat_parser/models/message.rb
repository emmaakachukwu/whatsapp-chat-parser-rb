module WhatsappChatParser
  module Models
    class Message
      attr_accessor :timestamp, :author, :body, :type, :platform

      def initialize(timestamp:, author:, body:, platform:)
        @timestamp = timestamp
        @author = author
        @body = body
        @platform = platform
        @type = message_type
      end

      private

      def message_type
        @author.nil? ? :system : :user
      end
    end
  end
end
