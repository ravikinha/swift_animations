# Swift Animations

SwiftUI-like declarative animations for Flutter. Zero boilerplate - no controllers, no ticker providers required!

## Installation

```yaml
dependencies:
  swift_animations: ^1.2.0
```

## Quick Start

```dart
import 'package:swift_animations/swift_animations.dart';

Container(
  width: 100,
  height: 100,
  color: Colors.blue,
)
  .animate()
  .fadeIn()
  .scale(1.2)
  .duration(500.ms)
```

## Features

### Transformations
- `.scale(value)` - Scale uniformly
- `.scaleX(value)` - Scale on X axis
- `.scaleY(value)` - Scale on Y axis
- `.rotate(degrees)` - Rotate by degrees

### Opacity
- `.fadeIn()` - Fade from 0 to 1
- `.fadeOut()` - Fade from 1 to 0
- `.opacity(value)` - Custom opacity (0.0 to 1.0)

### Slides
- `.slideX(value)` - Slide on X axis
- `.slideY(value)` - Slide on Y axis
- `.slideInTop()` - Slide in from top
- `.slideInBottom()` - Slide in from bottom
- `.slideInLeft()` - Slide in from left
- `.slideInRight()` - Slide in from right

### Special Effects
- `.bounce()` - Bounce animation curve
- `.pulse()` - Pulse animation curve
- `.fadeInScale(value)` - Combined fade and scale

### Spring Physics
- `.spring(mass, stiffness, damping, initialVelocity)` - Custom spring
- `.springIOS()` - iOS-style snappy spring
- `.springGentle()` - Gentle spring with smooth bounce
- `.springBouncy()` - Bouncy spring with high bounce

### Configuration
- `.duration(value)` - Animation duration (supports `500.ms`, `0.5.s`, `5.m`, or `Duration`)
- `.delay(value)` - Animation delay
- `.curve(curve)` - Custom animation curve
- `.repeat(reverse: bool)` - Infinite repeat
- `.repeatCount(count, reverse: bool)` - Repeat specific times
- `.persist()` - Keep animation state on rebuild

### Gesture Extensions
- `.sGestureDetector()` - Liquid tap effects with spring physics
  - `onPressed` - Tap callback
  - `onLongPress` - Long press callback
  - `scaleOnPress` - Scale amount on tap (default: 1.1)
  - `longPressDuration` - Long press duration (default: 500ms)
  - `autoScaleBySize` - Auto-scale based on widget size
  - `stretchSensitivity` - Stretch effect sensitivity
  - `translateSensitivity` - Translation sensitivity

## Examples

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

### Spring Animation
```dart
Container(
  width: 100,
  height: 100,
  color: Colors.purple,
)
  .animate()
  .fadeIn()
  .springIOS()
```

### Gesture Detector
```dart
Container(
  width: 100,
  height: 100,
  color: Colors.blue,
)
  .sGestureDetector(
    onPressed: () => print('Tapped'),
    onLongPress: () => print('Long pressed'),
  )
```

### Complex Animation
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

### Duration Shorthand
```dart
.animate().duration(500.ms)    // 500 milliseconds
.animate().duration(0.5.s)     // 0.5 seconds
.animate().duration(5.m)       // 5 minutes
.animate().duration(".500ms")  // String format
```

## Why Swift Animations?

- ✅ **No mixins needed** - Just use `StatefulWidget` or `StatelessWidget`
- ✅ **Zero boilerplate** - No controller setup or disposal
- ✅ **Clean API** - Simple chaining like SwiftUI
- ✅ **Automatic management** - All ticker providers handled internally
- ✅ **Visibility-based** - Animations start when widgets come into view
- ✅ **Scroll-aware** - Automatically detects scrolling
- ✅ **All platforms** - Works on iOS, Android, Web, macOS, Linux, Windows

## License

MIT License
