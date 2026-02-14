module WhatsappChatParser
  module Platforms
    module Ios
      module Pattern
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

        class << self
          def regex
            Regexp.new(
              "#{square_bracket_open_pattern}"\
              "#{date_pattern},#{space_pattern}"\
              "#{time_pattern}"\
              "#{square_bracket_close_pattern}"\
              "#{space_pattern}#{/[-~]?/.source}#{space_pattern}"\
              "#{author_pattern}"\
              "#{body_pattern}",
              Regexp::MULTILINE
            )
          end

          private

          def date_pattern
            PATTERNS.fetch_values(:day, :month, :year)
              .map(&:source)
              .join('/')
          end
  
          def time_pattern
            sourced_time_patterns = PATTERNS.slice(:hour, :minute, :second, :meridiem)
              .transform_values!(&:source)
  
            "#{sourced_time_patterns[:hour]}"\
              ":#{sourced_time_patterns[:minute]}"\
              "#{sourced_time_patterns[:second]}"\
              "#{sourced_time_patterns[:meridiem]}"
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

          def author_pattern
            PATTERNS[:author].source
          end

          def body_pattern
            PATTERNS[:body].source
          end
        end
      end
    end
  end
end
