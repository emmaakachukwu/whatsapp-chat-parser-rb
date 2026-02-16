RSpec.describe WhatsappChatParser::Models::Message do
  describe '#initialize' do
    it 'sets the correct attributes' do
      msg = described_class.new(
        timestamp: '2025-12-15 10:30:00',
        author: 'John Doe',
        body: 'Hello',
        platform: :android
      )
      expect(msg.timestamp).to eq('2025-12-15 10:30:00')
      expect(msg.author).to eq('John Doe')
      expect(msg.body).to eq('Hello')
      expect(msg.platform).to eq(:android)
      expect(msg.type).to eq(:user)
    end

    it 'sets type to :system when author is nil' do
      msg = described_class.new(
        timestamp: '2025-12-15 10:30:00',
        author: nil,
        body: 'System message',
        platform: :ios
      )
      expect(msg.type).to eq(:system)
    end
  end
end
