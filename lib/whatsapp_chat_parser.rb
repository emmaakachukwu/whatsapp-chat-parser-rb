require_relative 'whatsapp_chat_parser/platforms'
require_relative 'whatsapp_chat_parser/models/message'

module WhatsappChatParser
  class << self
    def parse(line)
      Platforms.parse(line)
    end
  end
end
