# Swift Animations

SwiftUI-like declarative animations for Flutter. Zero boilerplate - no controllers, no ticker providers required!

## Installation

```yaml
dependencies:
  swift_animations: ^1.2.2
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

### Navigation Animations
Platform-specific navigation animations with a fluent API:

**Available Navigation Methods:**
- `swift.push(route)` - Push a new route
- `swift.pushReplacement(route)` - Replace current route
- `swift.pushRoute(route)` - Push a route object
- `swift.pushNamed(routeName)` - Push a named route
- `swift.pushReplacementNamed(routeName)` - Replace with named route
- `swift.pushNamedAndRemoveUntil(routeName, predicate)` - Push named route and remove until
- `swift.pushAndRemoveUntil(route, predicate)` - Push route and remove until

**Configuration:**
- `.ios()` - Use iOS-style slide transition (from right)
- `.android()` - Use Android-style fade + slide up transition
- `.web()` - Use web-style fade transition
- `.duration(milliseconds)` - Animation duration (int or Duration)
- `.curve(curve)` - Animation curve (e.g., `Curves.easeInOut`)
- `.go(context)` - Execute navigation

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

### Navigation Animations

#### Basic Push Navigation
```dart
// iOS-style navigation
swift.push(NextPage())
  .ios()
  .duration(500)
  .curve(Curves.easeInOut)
  .go(context);

// Android-style navigation
swift.push(NextPage())
  .android()
  .duration(500)
  .curve(Curves.easeInOut)
  .go(context);
```

#### Push Replacement
```dart
swift.pushReplacement(HomePage())
  .ios()
  .duration(300)
  .go(context);
```

#### Push Named Route
```dart
swift.pushNamed('/details')
  .android()
  .duration(400)
  .curve(Curves.easeOut)
  .go(context, arguments: {'id': 123});
```

#### Push and Remove Until
```dart
swift.pushAndRemoveUntil(HomePage(), (route) => false)
  .ios()
  .duration(500)
  .go(context);
```

#### Push Named and Remove Until
```dart
swift.pushNamedAndRemoveUntil('/home', (route) => false)
  .android()
  .duration(400)
  .go(context);
```

#### Push Replacement Named
```dart
swift.pushReplacementNamed('/login')
  .ios()
  .duration(300)
  .go(context, result: 'logged_out');
```

## Why Swift Animations?

- ✅ **No mixins needed** - Just use `StatefulWidget` or `StatelessWidget`
- ✅ **Zero boilerplate** - No controller setup or disposal
- ✅ **Clean API** - Simple chaining like SwiftUI
- ✅ **Automatic management** - All ticker providers handled internally
- ✅ **Visibility-based** - Animations start when widgets come into view
- ✅ **Scroll-aware** - Automatically detects scrolling
- ✅ **All platforms** - Works on iOS, Android, Web, macOS, Linux, Windows

## ☕ Support the Project

**Love using Swift Animations?** Your support helps me create more amazing plugins, add new features, and keep improving the developer experience!

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/ravikinha)

Your contributions enable me to:
- 🚀 Build more Flutter plugins and packages
- ✨ Add exciting new features and improvements
- 🐛 Fix bugs faster and maintain high quality
- 📚 Create better documentation and examples
- 💡 Explore innovative ideas for the Flutter ecosystem

**Every contribution, big or small, makes a difference!** Thank you for supporting open-source development! 🙏

[**Support on Buy Me a Coffee →**](https://buymeacoffee.com/ravikinha)

## License

MIT License
