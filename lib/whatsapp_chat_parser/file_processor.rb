# frozen_string_literal: true

require 'stringio'

module WhatsappChatParser
  module FileProcessor
    class << self
      def parse(source, &)
        return enum_for(__method__, source) unless block_given?

        file = source.is_a?(StringIO) ? source : File.open(source)
        parse_io(file, &)
      end

      private

      def parse_io(io, &)
        return enum_for(__method__, io) unless block_given?

        accumulate_messages(io, &)
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
