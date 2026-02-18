# frozen_string_literal: true

module WhatsappChatParser
  module Platforms
    # Shared utilities for building regex patterns.
    module PatternHelpers
      class << self
        def join_sources(patterns, keys, separator)
          patterns.fetch_values(*keys).map(&:source).join(separator)
        end

        def source(patterns, key)
          patterns[key].source
        end

        def format_sources(patterns, keys, format_string)
          values = patterns.fetch_values(*keys).map(&:source)
          format_string % values
        end
      end
    end
  end
end
