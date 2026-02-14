require_relative '../lib/whatsapp_chat_parser'

# Android
WhatsappChatParser.parse('12/25/25, 10:00 AM - John Doe: Hello World')

# Ios
WhatsappChatParser.parse('[25/12/2025, 10:01:00] Jane Doe: Hello World')
