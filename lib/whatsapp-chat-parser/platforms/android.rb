# frozen_string_literal: true

module WhatsappChatParser
  module Platforms
    # Parser for Android WhatsApp chat exports.
    module Android
      extend Base

      class << self
        # Parses a line from an Android export.
        # @param line [String] The exported line.
        # @return [Models::Message, nil]
        def parse(line)
          super(line, :android, Pattern)
        end

        # Checks if a line matches the Android format.
        # @param line [String]
        # @return [Boolean]
        def matches?(line)
          super(line, Pattern)
        end

        private

        def extract_date_components(match, pattern_module)
          components = super
          components[:year] = components[:year].to_i + 2000
          components
        end
      end
    end
  end
end
