require_relative 'lib/whatsapp_chat_parser/version'

Gem::Specification.new do |spec|
  spec.name = 'whatsapp_chat_parser'
  spec.summary = 'A Ruby library that parses exported Whatsapp chat .txt files and converts them into structured, machine-readable data.'
  spec.version = WhatsappChatParser::VERSION
  spec.homepage = 'https://github.com/emmaakachukwu/whatsapp-chat-parser-rb'
  spec.license = 'MIT'

  spec.authors = ['Emmanuel Akachukwu']
  spec.email = ['emmanuelakachukwu1@gmail.com']
  
  spec.required_ruby_version = '>= 3.0'
  spec.files = Dir.glob('lib/**/*.rb') + %w[LICENSE README.md]
  spec.require_paths = ['lib']
end
