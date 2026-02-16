RSpec.describe WhatsappChatParser::Encoding do
  describe '.normalize_to_utf8' do
    it 'normalizes ASCII-8BIT string to UTF-8' do
      str = 'Hello'.force_encoding('ASCII-8BIT')
      normalized = described_class.normalize_to_utf8(str)
      expect(normalized.encoding).to eq(::Encoding::UTF_8)
      expect(normalized).to eq('Hello')
    end

    it 'handles UTF-8 BOM' do
      str = "\xEF\xBB\xBFHello".b
      normalized = described_class.normalize_to_utf8(str)
      expect(normalized).to eq('Hello')
      expect(normalized.encoding).to eq(::Encoding::UTF_8)
    end

    it 'handles special characters' do
      str = 'ACE™'.force_encoding('BINARY')
      normalized = described_class.normalize_to_utf8(str)
      expect(normalized).to eq('ACE™')
      expect(normalized.encoding).to eq(::Encoding::UTF_8)
    end
  end
end
