# frozen_string_literal: true

require 'stringio'

module WhatsappChatParser
  # Handles reading and processing chat export files.
  module FileProcessor
    class << self
      # Iterates through the source and yields parsed messages.
      # @param source [String, IO] The file path or IO object.
      # @yield [message] Yields each parsed message.
      # @yieldparam message [WhatsappChatParser::Models::Message]
      # @return [Enumerator] if no block is given.
      def parse(source, &block)
        return enum_for(__method__, source) unless block_given?

        file = source.is_a?(StringIO) ? source : File.open(source)
        parse_io(file, &block)
      end

      private

      # Processes an IO object.
      # @param io [IO] The input source.
      # @yield [message]
      def parse_io(io, &block)
        return enum_for(__method__, io) unless block_given?

        accumulate_messages(io, &block)
      end

      def accumulate_messages(io, &block)
        message = ''

        io.each_line do |line|
          if message_starts_here?(line)
            yield_message(message, &block) unless message.empty?
            message = line
          else
            message << line
          end
        end

        yield_message(message, &block) unless message.empty?
      end

      def yield_message(message)
        yield(Platforms.parse(message))
      end

      def message_starts_here?(line)
        !Platforms.parse(line).nil?
      end
    end
  end
end
