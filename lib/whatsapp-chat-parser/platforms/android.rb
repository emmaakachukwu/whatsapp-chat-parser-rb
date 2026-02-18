# frozen_string_literal: true

module WhatsappChatParser
  module Platforms
    # Parser for Android WhatsApp chat exports.
    module Android
      class << self
        # Parses a line from an Android export.
        # @param line [String] The exported line.
        # @return [Models::Message, nil]
        def parse(line)
          match = line.match(Pattern.regex)
          return unless match

          timestamp = extract_timestamp(match)
          author = extract(match, :author)
          body = extract(match, :body)

          Models::Message.new(timestamp: timestamp, author: author, body: body, platform: :android)
        end

        # Checks if a line matches the Android format.
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
          year = extract(match, :year).to_i + 2000

          { month: month, day: day, year: year }
        end

        def extract_time_components(match)
          hour = extract(match, :hour).to_i
          minute = extract(match, :minute).to_i
          meridiem = extract(match, :meridiem)
          hour = convert_to_24_hour(hour, meridiem)

          { hour: hour, minute: minute }
        end

        def convert_to_24_hour(hour, meridiem)
          meridiem = meridiem.upcase
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
            '%<year>04d-%<month>02d-%<day>02d %<hour>02d:%<minute>02d:00',
            year:   date[:year],
            month:  date[:month],
            day:    date[:day],
            hour:   time[:hour],
            minute: time[:minute]
          )
          # rubocop:enable Layout/HashAlignment
        end
      end
    end
  end
end
