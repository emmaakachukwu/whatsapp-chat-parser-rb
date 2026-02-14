module WhatsappChatParser
  module Platforms
    module Ios
      class << self
        def parse(line)
          match = line.match(Pattern.regex)
          return unless match

          timestamp = extract_timestamp(match)
          author = extract(match, :author)
          body = extract(match, :body)

          Models::Message.new(timestamp:, author:, body:, platform: :ios)
        end

        def matches?(line)
          Pattern.regex.match?(line)
        end

        private

        def extract(match, key)
          index = Pattern::PATTERNS.keys.index(key)
          match[index + 1]
        end
  
        def extract_timestamp(match)
          date_components = extract_date_components(match)
          time_components = extract_time_components(match)
  
          format_sql_timestamp(date_components, time_components)
        end

        def extract_date_components(match)
          month = extract(match, :month)
          day = extract(match, :day)
          year = extract(match, :year)

          { month:, day:, year: }
        end

        def extract_time_components(match)
          hour = extract(match, :hour).to_i
          minute = extract(match, :minute).to_i
          meridiem = extract(match, :meridiem)
          hour = convert_to_24_hour(hour, meridiem)

          { hour:, minute: }
        end

        def convert_to_24_hour(hour, meridiem)
          if meridiem == "PM" && hour < 12
            hour + 12
          elsif meridiem == "AM" && hour == 12
            0
          else
            hour
          end
        end

        def format_sql_timestamp(date, time)
          sprintf(
            "%04d-%02d-%02d %02d:%02d:00",
            date[:year],
            date[:month],
            date[:day],
            time[:hour],
            time[:minute]
          )
        end
      end
    end
  end
end
