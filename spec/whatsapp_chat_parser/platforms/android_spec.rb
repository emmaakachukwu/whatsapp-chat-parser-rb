# frozen_string_literal: true

RSpec.describe WhatsappChatParser::Platforms::Android do
  describe '.parse' do
    it 'parses a standard Android line' do
      line = '12/15/25, 10:30 AM - John Doe: Hello World'
      message = described_class.parse(line)
      expect(message.timestamp).to eq('2025-12-15 10:30:00')
      expect(message.author).to eq('John Doe')
      expect(message.body).to eq('Hello World')
    end

    it 'parses a line with PM' do
      line = '12/15/25, 10:30 PM - John Doe: Hello World'
      message = described_class.parse(line)
      expect(message.timestamp).to eq('2025-12-15 22:30:00')
    end

    it 'parses a system message (no author)' do
      line = '12/15/25, 10:30 AM - Messages and calls are end-to-end encrypted.'
      message = described_class.parse(line)
      expect(message.author).to be_nil
      expect(message.body).to eq('Messages and calls are end-to-end encrypted.')
    end

    it 'parses a line at 12:00 AM' do
      line = '12/15/25, 12:30 AM - John Doe: Hello World'
      message = described_class.parse(line)
      expect(message.timestamp).to eq('2025-12-15 00:30:00')
    end
  end
end
