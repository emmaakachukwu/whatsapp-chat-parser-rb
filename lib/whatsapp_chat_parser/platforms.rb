require_relative 'encoding'
require_relative 'platforms/android'
require_relative 'platforms/ios'
require_relative 'platforms/android/pattern'
require_relative 'platforms/ios/pattern'
require_relative 'platforms/pattern_helpers'

module WhatsappChatParser
  module Platforms
    PLATFORMS = [Android, Ios].freeze

    class << self
      def parse(line)
        sanitized = sanitize(line)
        platform = platform_for(sanitized)
        return nil unless platform

        platform.parse(sanitized)
      end

      private

      def platform_for(line)
        PLATFORMS.find { |platform| platform.matches?(line) }
      end

      def sanitize(line)
        Encoding.normalize_to_utf8(line).scrub(" ").squeeze(" ")
      end
    end
  end
end
