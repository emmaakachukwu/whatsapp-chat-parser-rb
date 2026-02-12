require_relative 'platforms/android'
require_relative 'platforms/ios'

module WhatsappChatParser
  module Platforms
    class UnknownPlatformError < StandardError; end

    class << self
      def detect(line)
        # Detect the platform based on the line
      end

      def parse(line)
        # Parse the line into a message object
      end
    end
  end
end
