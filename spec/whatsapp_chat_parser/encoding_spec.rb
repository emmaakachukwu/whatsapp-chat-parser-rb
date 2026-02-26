# frozen_string_literal: true

RSpec.describe WhatsappChatParser::Encoding do
  describe '.normalize_to_utf8' do
    it 'normalizes ASCII-8BIT string to UTF-8' do
      str = (+'Hello').force_encoding('ASCII-8BIT')
      normalized = described_class.normalize_to_utf8(str)
      expect(normalized.encoding).to eq(Encoding::UTF_8)
      expect(normalized).to eq('Hello')
    end

    it 'handles UTF-8 BOM' do
      str = "\xEF\xBB\xBFHello".b
      normalized = described_class.normalize_to_utf8(str)
      expect(normalized).to eq('Hello')
      expect(normalized.encoding).to eq(Encoding::UTF_8)
    end

    it 'handles UTF-16LE BOM' do
      str = "\xFF\xFEH\x00e\x00l\x00l\x00o\x00".b
      normalized = described_class.normalize_to_utf8(str)
      expect(normalized).to eq('Hello')
      expect(normalized.encoding).to eq(Encoding::UTF_8)
    end

    it 'handles UTF-16BE BOM' do
      str = "\xFE\xFF\x00H\x00e\x00l\x00l\x00o".b
      normalized = described_class.normalize_to_utf8(str)
      expect(normalized).to eq('Hello')
      expect(normalized.encoding).to eq(Encoding::UTF_8)
    end

    it 'handles special characters' do
      str = (+'ACE™').force_encoding('BINARY')
      normalized = described_class.normalize_to_utf8(str)
      expect(normalized).to eq('ACE™')
      expect(normalized.encoding).to eq(Encoding::UTF_8)
    end

    it 'handles short strings in strip_bom' do
      str = "\xFF".b
      normalized = described_class.normalize_to_utf8(str)
      expect(normalized).to eq(' ')
    end

    it 'returns the string as-is for other encodings in strip_bom' do
      str = (+'foo').force_encoding('ISO-8859-1')
      expect(described_class.send(:strip_bom, str, Encoding::ISO_8859_1)).to eq(str)
    end

    it 'handles ASCII-8BIT encoding' do
      str = (+"12/25/25, 10:00 AM - John Doe: Binary \xFF Data").force_encoding('ASCII-8BIT')
      normalized = described_class.normalize_to_utf8(str)
      expect(normalized.encoding).to eq(Encoding::UTF_8)
      expect(normalized).to eq('12/25/25, 10:00 AM - John Doe: Binary Data')
    end
  end
end
