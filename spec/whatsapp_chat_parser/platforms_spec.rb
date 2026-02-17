# frozen_string_literal: true

RSpec.describe WhatsappChatParser::Platforms do
  describe '.parse' do
    it 'delegates to the correct platform' do
      android_line = '12/15/25, 10:30 AM - John Doe: Hello World'
      ios_line = '[15/12/2025, 10:30:00 AM] John Doe: Hello World'

      # rubocop:disable RSpec/MessageSpies
      expect(WhatsappChatParser::Platforms::Android).to receive(:parse).with(android_line).and_call_original
      expect(WhatsappChatParser::Platforms::Ios).to receive(:parse).with(ios_line).and_call_original
      # rubocop:enable RSpec/MessageSpies

      described_class.parse(android_line)
      described_class.parse(ios_line)
    end
  end
end
