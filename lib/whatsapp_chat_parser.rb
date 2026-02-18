# frozen_string_literal: true

require_relative 'whatsapp_chat_parser/platforms'
require_relative 'whatsapp_chat_parser/models/message'
require_relative 'whatsapp_chat_parser/file_processor'

# Main entry point for the WhatsApp Chat Parser library.
module WhatsappChatParser
  class << self
    # Parses a single message line of a WhatsApp chat export.
    # @param line [String] The line to parse.
    # @return [WhatsappChatParser::Models::Message, nil] The parsed message or nil if message is malformed.
    def parse_line(line)
      Platforms.parse(line)
    end

    # Parses a WhatsApp chat export .txt file path or IO.
    # @param source [String, IO] The path to the file or an IO object.
    # @return [Enumerator<WhatsappChatParser::Models::Message>] Enumerator of parsed messages.
    def parse_file(source)
      FileProcessor.parse(source)
    end
  end
end
