require 'stringio'

module WhatsappChatParser
  module FileProcessor
    class << self
      def parse(source)
        return enum_for(__method__, source) unless block_given?

        file = source.is_a?(StringIO) ? source : File.open(source)
        parse_io(file) { |msg| yield msg }
      end

      private

      def parse_io(io)
        return enum_for(__method__, io) unless block_given?

        accumulated_message = ''
        io.each_line do |line|
          if message_starts_here?(line)
            yield(Platforms.parse(accumulated_message)) unless accumulated_message.empty?
            accumulated_message = line
          else
            accumulated_message += line
          end
        end

        yield(Platforms.parse(accumulated_message)) unless accumulated_message.empty?
      end

      def message_starts_here?(line)
        !Platforms.parse(line).nil?
      end
    end
  end
end
