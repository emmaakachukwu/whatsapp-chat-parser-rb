# frozen_string_literal: true

module WhatsappChatParser
  module Platforms
    module Android
      module Pattern
        # rubocop:disable Layout/HashAlignment
        PATTERNS = {
          month:    /(\d{1,2})/,
          day:      /(\d{1,2})/,
          year:     /(\d{2})/,
          hour:     /(\d{1,2})/,
          minute:   /(\d{2})/,
          meridiem: /\p{Space}*([AP]M)/,
          author:   /(?:([^:]+): )?/,
          body:     /(.*)/
        }.freeze
        # rubocop:enable Layout/HashAlignment

        class << self
          def regex
            Regexp.new(
              "#{date_pattern}, #{time_pattern} " \
              "- #{PatternHelpers.source(PATTERNS, :author)}#{PatternHelpers.source(PATTERNS, :body)}",
              Regexp::MULTILINE
            )
          end

          private

          def date_pattern
            PATTERNS.fetch_values(:month, :day, :year)
                    .map(&:source)
                    .join('/')
          end

          def time_pattern
            PatternHelpers.format_sources(PATTERNS, %i[hour minute meridiem], '%s:%s%s')
          end
        end
      end
    end
  end
end
