module WhatsappChatParser
  module Platforms
    module Android
      module Pattern
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

        class << self
          def regex
            Regexp.new(
              "#{date_pattern}, #{time_pattern}"\
              " - #{author_pattern}#{body_pattern}",
              Regexp::MULTILINE
            )
          end
  
          def date_pattern
            PATTERNS.fetch_values(:month, :day, :year)
              .map(&:source)
              .join('/')
          end
  
          def time_pattern
            sourced_time_patterns = PATTERNS.slice(:hour, :minute, :meridiem)
              .transform_values!(&:source)
  
            "#{sourced_time_patterns[:hour]}"\
              ":#{sourced_time_patterns[:minute]}"\
              "#{sourced_time_patterns[:meridiem]}"
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
