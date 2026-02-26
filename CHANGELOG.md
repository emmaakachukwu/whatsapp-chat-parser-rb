# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.2] - 2026-02-26

### Fixed
- Fixed `Encoding::CompatibilityError` caused by stripping an unscrubbed message line
- Fixed `FrozenError` caused by mutating a frozen `message` string during message line accumulation

## [0.1.1] - 2026-02-22

### Changed
- Refactored platform-specific parsers (`Android`, `Ios`) into a shared `Base` module to improve code maintainability (DRY).
- Optimized timestamp extraction logic in `Base` module to handle optional seconds across all platforms.

## [0.1.0] - 2026-02-18

### Added
- Initial release of `whatsapp-chat-parser`.
- Support for parsing exported WhatsApp chat `.txt` files from both **Android and iOS** platforms.
- Capability to parse both file streams and raw message strings.
- Automatic encoding normalization for cross-platform file compatibility.
- Support for multi-line messages.
- High-precision timestamp parsing (including second-level precision for iOS).
