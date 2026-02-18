# frozen_string_literal: true

require_relative 'lib/whatsapp-chat-parser/version'

Gem::Specification.new do |spec|
  spec.name = 'whatsapp-chat-parser'
  spec.summary = 'A Ruby library for parsing exported WhatsApp chat .txt files or message strings.'
  spec.version = WhatsappChatParser::VERSION
  spec.homepage = 'https://github.com/emmaakachukwu/whatsapp-chat-parser-rb'
  spec.license = 'MIT'
  spec.platform = Gem::Platform::RUBY
  spec.description = <<~DESC
    WhatsappChatParser parses exported WhatsApp chat .txt files (Android and iOS)
    and converts them into structured, machine-readable message objects.
    It supports both file inputs and raw message strings.
  DESC

  spec.authors = ['Emmanuel Akachukwu']
  spec.email = ['emmanuelakachukwu1@gmail.com']

  spec.required_ruby_version = '>= 3.0.0'
  spec.files = Dir.glob('lib/**/*.rb') + %w[LICENSE README.md CHANGELOG.md]
  spec.require_paths = ['lib']

  spec.metadata = {
    'homepage_uri'          => 'https://github.com/emmaakachukwu/whatsapp-chat-parser-rb',
    'bug_tracker_uri'       => 'https://github.com/emmaakachukwu/whatsapp-chat-parser-rb/issues',
    'changelog_uri'         => "https://github.com/emmaakachukwu/whatsapp-chat-parser-rb/blob/v#{spec.version}/CHANGELOG.md",
    'documentation_uri'     => "https://www.rubydoc.info/gems/whatsapp-chat-parser/#{spec.version}",
    'source_code_uri'       => "https://github.com/emmaakachukwu/whatsapp-chat-parser-rb/tree/v#{spec.version}",
    'keywords'              => 'whatsapp chat parser whatsapp-chat-parser text export android ios',
    'rubygems_mfa_required' => 'true'
  }

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'simplecov'
end
