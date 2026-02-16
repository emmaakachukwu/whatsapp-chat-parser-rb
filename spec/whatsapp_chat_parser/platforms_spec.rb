RSpec.describe WhatsappChatParser::Platforms do
  describe '.parse' do
    it 'delegates to the correct platform' do
      android_line = '12/15/25, 10:30 AM - John Doe: Hello World'
      ios_line = '[15/12/2025, 10:30:00 AM] John Doe: Hello World'

      expect(WhatsappChatParser::Platforms::Android).to receive(:parse).with(android_line).and_call_original
      described_class.parse(android_line)

      expect(WhatsappChatParser::Platforms::Ios).to receive(:parse).with(ios_line).and_call_original
      described_class.parse(ios_line)
    end
  end
end
