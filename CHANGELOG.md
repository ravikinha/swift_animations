# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.2.2] - 2025-01-XX

### Added
- Beautiful Buy Me a Coffee support button in example app
- Support section in README with encouraging messaging
- Direct link to support page for project development

### Changed
- Updated example app to include url_launcher for opening support links
- Enhanced README with support section highlighting project benefits

## [1.2.1] - 2025-01-XX

### Fixed
- Fixed `repeatCount()` method causing infinite loops instead of respecting the specified count
- Fixed repeat count logic for reverse animations to properly count complete cycles
- Improved status listener cleanup to prevent memory leaks

### Added
- Platform-specific navigation animations with fluent API
- `swift.push()`, `swift.pushReplacement()`, `swift.pushRoute()` methods
- `swift.pushNamed()`, `swift.pushReplacementNamed()` methods
- `swift.pushNamedAndRemoveUntil()`, `swift.pushAndRemoveUntil()` methods
- iOS-style slide transitions (from right)
- Android-style fade + slide up transitions
- Web-style fade transitions
- Configurable duration and curve for navigation animations

## [1.2.0] - 2025-01-XX

### Added
- Gesture extensions with `.sGestureDetector()` method
- Liquid tap effects with spring physics animations
- Scale animation on tap with iOS-style spring physics
- Stretch effects during drag gestures
- Long press support with configurable duration
- Auto-scaling based on widget size
- Customizable stretch and translate sensitivity

## [1.1.0] - 2025-01-XX

### Added
- Spring physics animations support
- `spring()` method for custom spring animations with configurable mass, stiffness, damping, and initial velocity
- `springIOS()` method for iOS-style snappy spring animations
- `springGentle()` method for gentle spring animations with smooth bounce
- `springBouncy()` method for bouncy spring animations with high bounce
- Support for unbounded animation controllers for spring physics

## [1.0.1] - 2025-01-XX

### Changed
- Updated homepage URL to https://swiftflutter.com/swiftanimation

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

