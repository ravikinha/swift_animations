# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-01-XX

### Added
- Initial release of `swift_animations` package
- SwiftUI-like declarative animation API
- Zero boilerplate animations - no mixins required
- Support for all Flutter platforms (iOS, Android, Web, macOS, Linux, Windows)
- Transform animations: scale, scaleX, scaleY, rotate
- Opacity animations: fadeIn, fadeOut, custom opacity
- Slide animations: slideX, slideY, slideInTop, slideInBottom, slideInLeft, slideInRight
- Special effects: bounce, pulse, fadeInScale
- Animation configuration: duration, delay, curve, repeat, repeatCount, persist
- Duration shorthand support: `.500ms`, `0.5.s`, `5.m`, etc.
- Number extensions for duration: `500.ms`, `1.5.s`, `2.m`

### Features
- Clean chaining API similar to SwiftUI
- Automatic ticker provider management (handled internally)
- No need for SingleTickerProviderStateMixin or TickerProviderStateMixin in user code
- Support for complex animation combinations
- Animation state persistence option

