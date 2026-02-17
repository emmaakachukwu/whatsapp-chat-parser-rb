# frozen_string_literal: true

RSpec.describe WhatsappChatParser::Platforms::Ios do
  describe '.parse' do
    it 'parses a standard iOS line with brackets' do
      line = '[15/12/2025, 10:30:00 AM] John Doe: Hello World'
      message = described_class.parse(line)
      expect(message.timestamp).to eq('2025-12-15 10:30:00')
      expect(message.author).to eq('John Doe')
      expect(message.body).to eq('Hello World')
    end

    it 'parses an iOS line without brackets' do
      line = '15/12/2025, 10:30:00 AM John Doe: Hello World'
      message = described_class.parse(line)
      expect(message).not_to be_nil
      expect(message.author).to eq('John Doe')
    end

    it 'parses a system message' do
      line = '[15/12/2025, 10:30:00 AM] Messages and calls are end-to-end encrypted.'
      message = described_class.parse(line)
      expect(message.author).to be_nil
      expect(message.body).to eq('Messages and calls are end-to-end encrypted.')
    end
  end
end
