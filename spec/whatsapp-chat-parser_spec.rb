# frozen_string_literal: true

RSpec.describe WhatsappChatParser do
  describe '.parse_line' do
    context 'with Android format' do
      let(:line) { '12/15/25, 10:30 AM - John Doe: Hello World' }

      it 'returns a Message object with correct attributes' do
        message = described_class.parse_line(line)
        expect(message).to be_a(WhatsappChatParser::Models::Message)
        expect(message.timestamp).to eq('2025-12-15 10:30:00')
        expect(message.author).to eq('John Doe')
        expect(message.body).to eq('Hello World')
        expect(message.platform).to eq(:android)
      end
    end

    context 'with iOS format' do
      let(:line) { '[15/12/2025, 10:30:00 AM] John Doe: Hello World' }

      it 'returns a Message object with correct attributes' do
        message = described_class.parse_line(line)
        expect(message).to be_a(WhatsappChatParser::Models::Message)
        expect(message.timestamp).to eq('2025-12-15 10:30:00')
        expect(message.author).to eq('John Doe')
        expect(message.body).to eq('Hello World')
        expect(message.platform).to eq(:ios)
      end
    end

    context 'with malformed line' do
      let(:line) { 'This is not a WhatsApp message' }

      it 'returns nil' do
        expect(described_class.parse_line(line)).to be_nil
      end
    end
  end

  describe '.parse_file' do
    let(:sample_file) { File.expand_path('fixtures/files/sample.txt', __dir__) }

    it 'parses the sample.txt file correctly' do
      messages = described_class.parse_file(sample_file).to_a

      expect(messages.size).to eq(7)
      expect(messages[0].author).to eq('John Doe')
      expect(messages[0].platform).to eq(:android)
      expect(messages[2].author).to eq('Alice')
      expect(messages[2].platform).to eq(:ios)
      expect(messages[2].timestamp).to eq('2025-12-15 10:32:03')
      expect(messages[4].author).to eq('Charlie')
      expect(messages[4].platform).to eq(:ios)
      expect(messages[6].author).to be_nil
      expect(messages[6].type).to eq(:system)
    end
  end
end
