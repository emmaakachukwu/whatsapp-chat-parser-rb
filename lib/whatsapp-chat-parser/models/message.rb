# frozen_string_literal: true

module WhatsappChatParser
  module Models
    # Represents a single WhatsApp message.
    class Message
      # @return [String] The date and time the message was sent (standardized SQL format).
      attr_accessor :timestamp
      # @return [String, nil] The name or phone number of the message author, or nil for system messages.
      attr_accessor :author
      # @return [String] The content of the message.
      attr_accessor :body
      # @return [Symbol] The type of message (:user or :system).
      attr_accessor :type
      # @return [Symbol] The platform the message was exported from (:android or :ios).
      attr_accessor :platform

      # Initializes a new Message object.
      # @param timestamp [String] The standardized timestamp.
      # @param author [String, nil] The author of the message.
      # @param body [String] The message body.
      # @param platform [Symbol] The export platform.
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
