# frozen_string_literal: true

module WhatsappChatParser
  module Encoding
    UTF8_BOM    = "\xEF\xBB\xBF".b.freeze
    UTF16LE_BOM = "\xFF\xFE".b.freeze
    UTF16BE_BOM = "\xFE\xFF".b.freeze
    FALLBACK_ENCODING = 'UTF-8'

    class << self
      def normalize_to_utf8(line)
        enc = encoding_for(line)
        str = line.to_s.dup.force_encoding(enc)
        str = strip_bom(str, enc)
        unless enc == ::Encoding::UTF_8
          str = str.encode(
            ::Encoding::UTF_8, invalid: :replace, undef: :replace
          )
        end

        str
      end

      private

      def encoding_for(line)
        raw = line.to_s.dup.force_encoding(::Encoding::BINARY)
        if raw.start_with?(UTF8_BOM)
          ::Encoding::UTF_8
        elsif raw.start_with?(UTF16LE_BOM)
          ::Encoding::UTF_16LE
        elsif raw.start_with?(UTF16BE_BOM)
          ::Encoding::UTF_16BE
        else
          ::Encoding.find(FALLBACK_ENCODING)
        end
      end

      def strip_bom(str, encoding)
        case encoding
        when ::Encoding::UTF_8
          str.start_with?("\uFEFF") ? str.delete_prefix("\uFEFF") : str
        when ::Encoding::UTF_16LE, ::Encoding::UTF_16BE
          str.bytesize >= 2 ? str.byteslice(2..).force_encoding(encoding) : str
        else
          str
        end
      end
    end
  end
end
