# frozen_string_literal: true

module WhatsappChatParser
  module Platforms
    # Parser for iOS WhatsApp chat exports.
    module Ios
      class << self
        # Parses a line from an iOS export.
        # @param line [String] The exported line.
        # @return [Models::Message, nil]
        def parse(line)
          match = line.match(Pattern.regex)
          return unless match

          timestamp = extract_timestamp(match)
          author = extract(match, :author)
          body = extract(match, :body)

          Models::Message.new(timestamp: timestamp, author: author, body: body, platform: :ios)
        end

        # Checks if a line matches the iOS format.
        # @param line [String]
        # @return [Boolean]
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

          { month: month, day: day, year: year }
        end

        def extract_time_components(match)
          hour = extract(match, :hour).to_i
          minute = extract(match, :minute).to_i
          second = extract(match, :second)
          meridiem = extract(match, :meridiem)
          hour = convert_to_24_hour(hour, meridiem)

          { hour: hour, minute: minute, second: second }
        end

        def convert_to_24_hour(hour, meridiem)
          if meridiem == 'PM' && hour < 12
            hour + 12
          elsif meridiem == 'AM' && hour == 12
            0
          else
            hour
          end
        end

        def format_sql_timestamp(date, time)
          # rubocop:disable Layout/HashAlignment
          format(
            '%<year>04d-%<month>02d-%<day>02d %<hour>02d:%<minute>02d:%<second>02d',
            year:   date[:year],
            month:  date[:month],
            day:    date[:day],
            hour:   time[:hour],
            minute: time[:minute],
            second: time[:second]
          )
          # rubocop:enable Layout/HashAlignment
        end
      end
    end
  end
end
