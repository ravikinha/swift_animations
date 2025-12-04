# Swift Animations

SwiftUI-like declarative animations for Flutter. Zero boilerplate - no controllers, no ticker providers required! Works on all platforms.

## Features

- ✅ **No mixins needed** - Just use `StatefulWidget` or `StatelessWidget`
- ✅ **Zero boilerplate** - No controller setup or disposal
- ✅ **Clean API** - Simple chaining like SwiftUI
- ✅ **Automatic management** - All ticker providers handled internally
- ✅ **Visibility-based** - Animations only start when widgets come into view
- ✅ **Scroll-aware** - Automatically detects scrolling and triggers animations
- ✅ **All platforms** - Works on iOS, Android, Web, macOS, Linux, and Windows

## Installation

Add `swift_animations` to your `pubspec.yaml`:

```yaml
dependencies:
  swift_animations: ^1.0.0
```

## Quick Start

```dart
import 'package:swift_animations/swift_animations.dart';

Container(
  width: 120,
  height: 120,
  decoration: BoxDecoration(
    color: Colors.purple,
    borderRadius: BorderRadius.circular(20),
  ),
)
  .animate()
  .fadeIn()
  .scale(1.2)
  .repeat(reverse: true)
```

## Usage

### Basic Animation

```dart
Container(
  width: 100,
  height: 100,
  color: Colors.blue,
)
  .animate()
  .fadeIn()
  .scale(1.5)
```

### Available Animations

**Transformations:**
- `.scale(value)` - Scale uniformly
- `.scaleX(value)` - Scale on X axis
- `.scaleY(value)` - Scale on Y axis
- `.rotate(degrees)` - Rotate by degrees

**Opacity:**
- `.fadeIn()` - Fade from 0 to 1
- `.fadeOut()` - Fade from 1 to 0
- `.opacity(value)` - Custom opacity (0.0 to 1.0)

**Slides:**
- `.slideX(value)` - Slide on X axis
- `.slideY(value)` - Slide on Y axis
- `.slideInTop()` - Slide in from top
- `.slideInBottom()` - Slide in from bottom
- `.slideInLeft()` - Slide in from left
- `.slideInRight()` - Slide in from right

**Special Effects:**
- `.bounce()` - Bounce animation curve
- `.pulse()` - Pulse animation curve
- `.fadeInScale(value)` - Combined fade and scale

**Configuration:**
- `.duration(value)` - Animation duration (supports `.500ms`, `0.5.s`, `5.m`, or `Duration`)
- `.delay(value)` - Animation delay
- `.curve(curve)` - Custom animation curve
- `.repeat(reverse: bool)` - Infinite repeat
- `.repeatCount(count, reverse: bool)` - Repeat specific times
- `.persist()` - Keep animation state on rebuild

### Shorthand Duration Examples

```dart
// String format
.animate().duration(".500ms")
.animate().duration("0.5s")
.animate().duration("5m")

// Number extensions (recommended)
.animate().duration(500.ms)
.animate().duration(0.5.s)
.animate().duration(5.m)

// Traditional Duration
.animate().duration(const Duration(seconds: 5))
```

### Complex Example

```dart
Container(
  width: 120,
  height: 120,
  decoration: BoxDecoration(
    color: Colors.purple,
    borderRadius: BorderRadius.circular(20),
  ),
)
  .animate()
  .fadeIn()
  .scale(1.2)
  .slideInBottom()
  .rotate(180)
  .duration(1.5.s)
  .curve(Curves.easeInOut)
  .repeat(reverse: true)
```

### More Examples

**Bounce Animation:**
```dart
Container(
  width: 100,
  height: 100,
  color: Colors.red,
)
  .animate()
  .bounce()
  .scale(1.5)
  .duration(1.s)
  .repeat(reverse: true)
```

**Pulse Animation:**
```dart
Icon(Icons.favorite, size: 50, color: Colors.red)
  .animate()
  .pulse()
  .scale(1.3)
  .duration(0.8.s)
  .repeat(reverse: true)
```

**Slide In with Delay:**
```dart
Card(
  child: ListTile(
    title: Text('Animated Item'),
  ),
)
  .animate()
  .slideInLeft()
  .fadeIn()
  .delay(200.ms)
  .duration(500.ms)
```

**Rotate and Scale:**
```dart
Container(
  width: 80,
  height: 80,
  color: Colors.blue,
)
  .animate()
  .rotate(360)
  .scale(1.5)
  .duration(2.s)
  .repeat(reverse: false)
```

## Why Mixin-Free?

Traditional Flutter animations require `SingleTickerProviderStateMixin` or `TickerProviderStateMixin` in your widget class. With `swift_animations`:

- ✅ **No mixins needed** - Just use `StatefulWidget` or `StatelessWidget`
- ✅ **Zero boilerplate** - No controller setup or disposal
- ✅ **Clean API** - Simple chaining like SwiftUI
- ✅ **Automatic management** - All ticker providers handled internally

The library uses `TickerProviderStateMixin` internally, but you never see it - it's completely hidden from your code!

## Visibility-Based Animations

Animations automatically start only when widgets become visible on screen. This means:

- 🎯 **Performance optimized** - Animations don't run for off-screen widgets
- 📜 **Scroll-friendly** - Perfect for scrollable lists - animations trigger as you scroll
- 🔄 **Automatic detection** - No manual visibility checks needed
- ⚡ **Efficient** - Only animates what's visible, saving resources

When you scroll through a list, animations will automatically start as each widget comes into view, creating a smooth, performant experience!

## Platform Support

This package works on all Flutter platforms:
- ✅ iOS
- ✅ Android
- ✅ Web
- ✅ macOS
- ✅ Linux
- ✅ Windows

## License

MIT License - see LICENSE file for details.

# swift_animations
