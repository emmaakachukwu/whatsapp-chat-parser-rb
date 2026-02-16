RSpec.describe WhatsappChatParser::FileProcessor do
  describe '.parse' do
    let(:android_content) do
      <<~TEXT
        12/15/25, 10:30 AM - John Doe: Hello
        This is a multi-line
        message.
        12/15/25, 10:31 AM - Jane Smith: Hi there!
      TEXT
    end
    let(:io) { StringIO.new(android_content) }

    it 'yields parsed messages' do
      messages = []
      described_class.parse(io) { |msg| messages << msg }

      expect(messages.size).to eq(2)
      expect(messages[0].author).to eq('John Doe')
      expect(messages[0].body).to eq("Hello\nThis is a multi-line\nmessage.")
      expect(messages[1].author).to eq('Jane Smith')
      expect(messages[1].body).to eq('Hi there!')
    end

    it 'returns an enumerator if no block is given' do
      expect(described_class.parse(io)).to be_a(Enumerator)
    end
  end
end
