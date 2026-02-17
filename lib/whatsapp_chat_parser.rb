# frozen_string_literal: true

require_relative 'whatsapp_chat_parser/platforms'
require_relative 'whatsapp_chat_parser/models/message'
require_relative 'whatsapp_chat_parser/file_processor'

module WhatsappChatParser
  class << self
    def parse_line(line)
      Platforms.parse(line)
    end

    def parse_file(source)
      FileProcessor.parse(source)
    end
  end
end
