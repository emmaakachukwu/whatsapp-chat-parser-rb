# frozen_string_literal: true

module WhatsappChatParser
  module Platforms
    # Base module for shared platform parser logic
    module Base
      # Parses a line from an export
      # @param line [String] The exported line
      # @param platform [Symbol] The platform identifier
      # @param pattern_module [Module] The pattern module for the platform
      # @return [Models::Message, nil]
      def parse(line, platform, pattern_module)
        match = line.match(pattern_module.regex)
        return unless match

        timestamp = extract_timestamp(match, pattern_module)
        author = extract(match, pattern_module, :author)
        body = extract(match, pattern_module, :body)

        Models::Message.new(timestamp: timestamp, author: author, body: body, platform: platform)
      end

      # Checks if a line matches the platform format
      # @param line [String]
      # @param pattern_module [Module]
      # @return [Boolean]
      def matches?(line, pattern_module)
        pattern_module.regex.match?(line)
      end

      private

      # Extracts a value from a match based on a pattern key
      # @param match [MatchData]
      # @param pattern_module [Module]
      # @param key [Symbol]
      # @return [String, nil]
      def extract(match, pattern_module, key)
        index = pattern_module::PATTERNS.keys.index(key)
        return unless index

        match[index + 1]
      end

      # Extracts and formats a timestamp from a match
      # @param match [MatchData]
      # @param pattern_module [Module]
      # @return [String]
      def extract_timestamp(match, pattern_module)
        date_components = extract_date_components(match, pattern_module)
        time_components = extract_time_components(match, pattern_module)

        format_sql_timestamp(date_components, time_components)
      end

      # Extracts date components from a match
      # @param match [MatchData]
      # @param pattern_module [Module]
      # @return [Hash]
      def extract_date_components(match, pattern_module)
        {
          month: extract(match, pattern_module, :month),
          day: extract(match, pattern_module, :day),
          year: extract(match, pattern_module, :year)
        }
      end

      # Extracts time components from a match
      # @param match [MatchData]
      # @param pattern_module [Module]
      # @return [Hash]
      def extract_time_components(match, pattern_module)
        hour = extract(match, pattern_module, :hour).to_i
        minute = extract(match, pattern_module, :minute).to_i
        second = extract(match, pattern_module, :second).to_i
        meridiem = extract(match, pattern_module, :meridiem)
        hour = convert_to_24_hour(hour, meridiem)

        { hour: hour, minute: minute, second: second }
      end

      # Converts an hour to 24-hour format
      # @param hour [Integer]
      # @param meridiem [String, nil]
      # @return [Integer]
      def convert_to_24_hour(hour, meridiem)
        return hour unless meridiem

        meridiem = meridiem.upcase
        if meridiem == 'PM' && hour < 12
          hour + 12
        elsif meridiem == 'AM' && hour == 12
          0
        else
          hour
        end
      end

      # Formats date and time components into an SQL timestamp
      # @param date [Hash]
      # @param time [Hash]
      # @return [String]
      def format_sql_timestamp(date, time)
        # rubocop:disable Layout/HashAlignment
        format(
          '%<year>04d-%<month>02d-%<day>02d %<hour>02d:%<minute>02d:%<second>02d',
          year:   date[:year],
          month:  date[:month],
          day:    date[:day],
          hour:   time[:hour],
          minute: time[:minute],
          second: time[:second] || 0
        )
        # rubocop:enable Layout/HashAlignment
      end
    end
  end
end
