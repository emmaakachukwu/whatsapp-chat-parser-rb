# frozen_string_literal: true

module WhatsappChatParser
  module Platforms
    module Ios
      # Regex patterns and builders for iOS WhatsApp exports.
      module Pattern
        # rubocop:disable Layout/HashAlignment
        PATTERNS = {
          day:      /(\d{1,2})/,
          month:    /(\d{1,2})/,
          year:     /(\d{4})/,
          hour:     /(\d{1,2})/,
          minute:   /(\d{2})/,
          second:   /(?::(\d{2}))?/,
          meridiem: /\p{Space}*([AP]M)?/,
          author:   /(?:([^:]+?)\p{Space}*:\p{Space}*)?/,
          body:     /(.*)/
        }.freeze
        # rubocop:enable Layout/HashAlignment

        class << self
          # Returns the compiled regex for iOS chat exports.
          # @return [Regexp]
          def regex
            Regexp.new(
              "#{square_bracket_open_pattern}" \
              "#{date_pattern},#{space_pattern}" \
              "#{time_pattern}" \
              "#{square_bracket_close_pattern}" \
              "#{space_pattern}#{/[-~]?/.source}#{space_pattern}" \
              "#{PatternHelpers.source(PATTERNS, :author)}#{PatternHelpers.source(PATTERNS, :body)}",
              Regexp::MULTILINE
            )
          end

          private

          def date_pattern
            PatternHelpers.join_sources(PATTERNS, %i[day month year], '/')
          end

          def time_pattern
            PatternHelpers.format_sources(
              PATTERNS, %i[hour minute second meridiem], '%s:%s%s%s'
            )
          end

          def space_pattern
            /\p{Space}*/.source
          end

          def square_bracket_open_pattern
            /\[?/.source
          end

          def square_bracket_close_pattern
            /\]?/.source
          end
        end
      end
    end
  end
end
