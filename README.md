# WhatsApp Chat Parser

A Ruby library that parses exported WhatsApp chat `.txt` files and converts them into structured, machine-readable data. Designed for downstream processing such as analytics, ETL pipelines, storage, and transformation — not for rendering UI or interacting with the WhatsApp API.

## Features

- **Platform support**: Handles both iOS and Android WhatsApp chat exports
- **Structured output**: Normalized message records suitable for JSON, databases, or further transformation
- **Robust parsing**: Detects platform-specific formats, normalizes timestamps, and groups multi-line messages
- **Deterministic**: No dependencies, explicit platform handling, predictable output structure
- **Fail-safe**: Skips or handles malformed lines when possible instead of aborting

## Installation

Add to your Gemfile:

```ruby
gem 'whatsapp_chat_parser'
```

Then run:

```bash
bundle install
```

Or install directly:

```bash
gem install whatsapp_chat_parser
```

## Usage

Provide the contents (or path) of a WhatsApp chat export and parse it into structured records:

```ruby
require 'whatsapp_chat_parser'

# From a string (e.g. file contents)
content = File.read('path/to/chat.txt')
messages = WhatsAppChatParser.parse(content)

# Each message is a normalized record with:
# - timestamp  (normalized format)
# - author    (name or identifier when present)
# - message   (full content, including multi-line)
# - type      (user message, system message, etc.)
messages.each do |msg|
  puts "#{msg.timestamp} | #{msg.author}: #{msg.message}"
end
```

The output is suitable for serialization (JSON), database insertion, or pipelines.

## Output format

Each parsed record includes:

| Field       | Description                                        |
|-------------|----------------------------------------------------|
| `timestamp` | Normalized date/time (consistent across platforms) |
| `author`    | Sender name or identifier (when present)           |
| `message`   | Full message content (multi-line messages grouped) |
| `type`      | e.g. user message, system message                  |

## Design principles

- **Deterministic parsing** — Same input yields same output
- **No dependencies** — Self-contained Ruby
- **Explicit platform handling** — iOS vs Android format differences are handled explicitly
- **Predictable structure** — Stable, documented output schema

## Use cases

- Chat analytics and reporting
- Data migration or archival
- ETL pipelines into databases or spreadsheets
- Automated processing of exported WhatsApp conversations

## Non-goals

This library does **not**:

- Interact with WhatsApp APIs
- Require network access
- Perform message interpretation, sentiment analysis, or NLP
- Handle encrypted or proprietary WhatsApp data formats

Input must be unmodified exports from WhatsApp’s “Export Chat” feature.

## How to export WhatsApp chats

To use this library you need a plain-text export of a WhatsApp conversation. Use WhatsApp’s built-in **Export Chat** and choose **Without media** so you get a single `.txt` file.

- [Android](https://faq.whatsapp.com/1180414079177245?cms_platform=android)
- [iOS](https://faq.whatsapp.com/1180414079177245/?cms_platform=iphone)

Use the exported `.txt` file as-is; do not edit the format. This library supports both Android and iOS export formats.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome. Please open an issue or pull request on the project repository.
