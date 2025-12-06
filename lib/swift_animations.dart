/// SwiftUI-like declarative animations for Flutter
/// 
/// Zero boilerplate - no controllers, no ticker providers required!
/// 
/// ```dart
/// import 'package:swift_animations/swift_animations.dart';
/// 
/// Container(
///   width: 120,
///   height: 120,
///   decoration: BoxDecoration(
///     color: Colors.purple,
///     borderRadius: BorderRadius.circular(20),
///   ),
/// )
///   .animate()
///   .scale(1.2)
///   .fadeIn()
///   .repeat(reverse: true)
/// ```
library;

export 'src/animate.dart';
export 'src/gesture_extensions.dart';
export 'src/navigation.dart';

