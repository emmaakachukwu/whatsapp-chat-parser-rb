# frozen_string_literal: true

module WhatsappChatParser
  module Platforms
    # Parser for iOS WhatsApp chat exports
    module Ios
      extend Base

      class << self
        # Parses a line from an iOS export
        # @param line [String] The exported line
        # @return [Models::Message, nil]
        def parse(line)
          super(line, :ios, Pattern)
        end

        # Checks if a line matches the iOS format
        # @param line [String]
        # @return [Boolean]
        def matches?(line)
          super(line, Pattern)
        end
      end
    end
  end
end
