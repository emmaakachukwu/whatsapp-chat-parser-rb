# frozen_string_literal: true

require_relative '../lib/whatsapp-chat-parser'
require 'stringio'
require 'pp'

puts '--- WhatsApp Chat Parser Example ---'

# -----------------------------
# Parsing a single Android line
# -----------------------------
puts "\nAndroid line:"
android_line = '12/25/25, 10:00 AM - John Doe: Hello World'
parsed_android = WhatsappChatParser.parse_line(android_line)
pp parsed_android

# -----------------------------
# Parsing a single iOS line
# -----------------------------
puts "\niOS line:"
ios_line = '[25/12/2025, 10:01:00] Jane Doe: Hello World'
parsed_ios = WhatsappChatParser.parse_line(ios_line)
pp parsed_ios

# -----------------------------
# Parsing a file
# -----------------------------
puts "\nFile:"
sample_file = File.expand_path('../spec/fixtures/files/sample.txt', __dir__)
WhatsappChatParser.parse_file(sample_file).each_with_index do |msg, i|
  puts "Message #{i + 1}:"
  pp msg
end

# -----------------------------
# Parsing from IO
# -----------------------------
puts "\nIO:"
io_content = '12/25/25, 10:02 AM - John Doe: Lorem Ipsum'
io = StringIO.new(io_content)
WhatsappChatParser.parse_file(io).each_with_index do |msg, i|
  puts "Message #{i + 1}:"
  pp msg
end

puts "\n--- End of Example ---"
