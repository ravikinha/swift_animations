/// SwiftUI-like declarative animations for Flutter
/// 
/// Zero boilerplate - no controllers, no ticker providers required!
/// 
/// ```dart
/// Box()
///   .animate()
///   .scale(1.2)
///   .fadeIn()
///   .repeat(reverse: true)
/// ```
library;

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'dart:math' as math;

/// Helper class for shorthand duration notation
/// Supports formats like: .500ms, .5s, .5m, 500ms, 5s, 5m
class DurationShorthand {
  final Duration duration;
  
  const DurationShorthand(this.duration);
  
  /// Parse shorthand duration string
  /// Supports: .500ms, .5s, .5m, 500ms, 5s, 5m, 1.5s, etc.
  /// Note: Leading dot is just stylistic - ".500ms" = "500ms" = 500 milliseconds
  /// For decimal values, use "0.5s" not ".5s" (or use number extensions: 0.5.s)
  factory DurationShorthand.parse(String value) {
    String cleaned = value.trim();
    
    // Remove leading dot if present (it's just stylistic)
    if (cleaned.startsWith('.')) {
      cleaned = cleaned.substring(1);
    }
    
    // Parse the value and unit
    final regex = RegExp(r'^(\d+\.?\d*)\s*(ms|s|m|h)$', caseSensitive: false);
    final match = regex.firstMatch(cleaned);
    
    if (match == null) {
      throw FormatException('Invalid duration format: $value. Expected format: .500ms, .5s, .5m, etc.');
    }
    
    final numValue = double.parse(match.group(1)!);
    final unit = match.group(2)!.toLowerCase();
    
    switch (unit) {
      case 'ms':
        return DurationShorthand(Duration(milliseconds: numValue.round()));
      case 's':
        return DurationShorthand(Duration(milliseconds: (numValue * 1000).round()));
      case 'm':
        return DurationShorthand(Duration(milliseconds: (numValue * 60 * 1000).round()));
      case 'h':
        return DurationShorthand(Duration(milliseconds: (numValue * 60 * 60 * 1000).round()));
      default:
        throw FormatException('Unknown duration unit: $unit');
    }
  }
  
  /// Create from milliseconds
  factory DurationShorthand.ms(double milliseconds) {
    return DurationShorthand(Duration(milliseconds: milliseconds.round()));
  }
  
  /// Create from seconds
  factory DurationShorthand.s(double seconds) {
    return DurationShorthand(Duration(milliseconds: (seconds * 1000).round()));
  }
  
  /// Create from minutes
  factory DurationShorthand.m(double minutes) {
    return DurationShorthand(Duration(milliseconds: (minutes * 60 * 1000).round()));
  }
  
  /// Create from hours
  factory DurationShorthand.h(double hours) {
    return DurationShorthand(Duration(milliseconds: (hours * 60 * 60 * 1000).round()));
  }
}

/// Extension to create DurationShorthand from strings
extension DurationStringExtension on String {
  /// Parse string as duration shorthand
  /// Example: ".500ms".toDuration(), ".5s".toDuration()
  DurationShorthand toDuration() => DurationShorthand.parse(this);
}

/// Extension methods on numbers for duration shorthand
/// Example: 500.ms, 0.5.s, 5.m
extension DurationNumberExtension on num {
  /// Create duration in milliseconds
  /// Example: 500.ms
  DurationShorthand get ms => DurationShorthand.ms(toDouble());
  
  /// Create duration in seconds
  /// Example: 0.5.s, 5.s
  DurationShorthand get s => DurationShorthand.s(toDouble());
  
  /// Create duration in minutes
  /// Example: 5.m, 0.5.m
  DurationShorthand get m => DurationShorthand.m(toDouble());
  
  /// Create duration in hours
  /// Example: 1.h, 0.5.h
  DurationShorthand get h => DurationShorthand.h(toDouble());
}

/// Animation configuration that can be chained
class AnimationConfig {
  // Transform animations
  double? scale;
  double? scaleX;
  double? scaleY;
  
  // Opacity
  double? opacity;
  
  // Translation
  Offset? translate;
  double? translateX;
  double? translateY;
  
  // Rotation
  double? rotate;
  
  // Slide directions
  SlideDirection? slideIn;
  
  // Animation settings
  Duration duration;
  Duration delay;
  Curve curve;
  bool repeat;
  bool reverse;
  int? repeatCount;
  bool persist;
  
  // Special animations
  bool bounce;
  bool pulse;
  
  // Spring physics
  SpringDescription? spring;
  double? springInitialVelocity;
  bool useSpring;
  
  AnimationConfig({
    this.scale,
    this.scaleX,
    this.scaleY,
    this.opacity,
    this.translate,
    this.translateX,
    this.translateY,
    this.rotate,
    this.slideIn,
    this.duration = const Duration(milliseconds: 300),
    this.delay = Duration.zero,
    this.curve = Curves.easeInOut,
    this.repeat = false,
    this.reverse = false,
    this.repeatCount,
    this.persist = false,
    this.bounce = false,
    this.pulse = false,
    this.spring,
    this.springInitialVelocity,
    this.useSpring = false,
  });
  
  AnimationConfig copyWith({
    double? scale,
    double? scaleX,
    double? scaleY,
    double? opacity,
    Offset? translate,
    double? translateX,
    double? translateY,
    double? rotate,
    SlideDirection? slideIn,
    Duration? duration,
    Duration? delay,
    Curve? curve,
    bool? repeat,
    bool? reverse,
    int? repeatCount,
    bool? persist,
    bool? bounce,
    bool? pulse,
    SpringDescription? spring,
    double? springInitialVelocity,
    bool? useSpring,
  }) {
    return AnimationConfig(
      scale: scale ?? this.scale,
      scaleX: scaleX ?? this.scaleX,
      scaleY: scaleY ?? this.scaleY,
      opacity: opacity ?? this.opacity,
      translate: translate ?? this.translate,
      translateX: translateX ?? this.translateX,
      translateY: translateY ?? this.translateY,
      rotate: rotate ?? this.rotate,
      slideIn: slideIn ?? this.slideIn,
      duration: duration ?? this.duration,
      delay: delay ?? this.delay,
      curve: curve ?? this.curve,
      repeat: repeat ?? this.repeat,
      reverse: reverse ?? this.reverse,
      repeatCount: repeatCount ?? this.repeatCount,
      persist: persist ?? this.persist,
      bounce: bounce ?? this.bounce,
      pulse: pulse ?? this.pulse,
      spring: spring ?? this.spring,
      springInitialVelocity: springInitialVelocity ?? this.springInitialVelocity,
      useSpring: useSpring ?? this.useSpring,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AnimationConfig &&
        other.scale == scale &&
        other.scaleX == scaleX &&
        other.scaleY == scaleY &&
        other.opacity == opacity &&
        other.translate == translate &&
        other.translateX == translateX &&
        other.translateY == translateY &&
        other.rotate == rotate &&
        other.slideIn == slideIn &&
        other.duration == duration &&
        other.delay == delay &&
        other.curve == curve &&
        other.repeat == repeat &&
        other.reverse == reverse &&
        other.repeatCount == repeatCount &&
        other.persist == persist &&
        other.bounce == bounce &&
      other.pulse == pulse &&
      other.spring == spring &&
      other.springInitialVelocity == springInitialVelocity &&
      other.useSpring == useSpring;
  }
  
  @override
  int get hashCode {
    return Object.hashAll([
      scale,
      scaleX,
      scaleY,
      opacity,
      translate,
      translateX,
      translateY,
      rotate,
      slideIn,
      duration,
      delay,
      curve,
      repeat,
      reverse,
      repeatCount,
      persist,
      bounce,
      pulse,
      spring,
      springInitialVelocity,
      useSpring,
    ]);
  }
}

/// Direction for slide-in animations
enum SlideDirection {
  top,
  bottom,
  left,
  right,
}

/// Extension to add animate() method to any Widget
extension AnimateExtension on Widget {
  /// Start the animation chain
  AnimatedWidgetBuilder animate() {
    return AnimatedWidgetBuilder(
      config: AnimationConfig(),
      child: this,
    );
  }
}

/// Builder that accumulates animation configuration
/// Can be used directly as a Widget in widget trees
class AnimatedWidgetBuilder extends StatelessWidget {
  final Widget child;
  final AnimationConfig config;
  
  const AnimatedWidgetBuilder({
    super.key,
    required this.child,
    required this.config,
  });
  
  @override
  Widget build(BuildContext context) {
    return _AnimatedWidgetWrapper(
      config: config,
      child: child,
    );
  }
  
  // Factory constructor for chaining
  AnimatedWidgetBuilder _copyWith({
    Widget? child,
    AnimationConfig? config,
  }) {
    return AnimatedWidgetBuilder(
      config: config ?? this.config,
      child: child ?? this.child,
    );
  }
  
  /// Apply scale transformation
  AnimatedWidgetBuilder scale(double value) {
    return _copyWith(config: config.copyWith(scale: value));
  }
  
  /// Apply scale on X axis
  AnimatedWidgetBuilder scaleX(double value) {
    return _copyWith(config: config.copyWith(scaleX: value));
  }
  
  /// Apply scale on Y axis
  AnimatedWidgetBuilder scaleY(double value) {
    return _copyWith(config: config.copyWith(scaleY: value));
  }
  
  /// Fade in animation (opacity 0 to 1)
  AnimatedWidgetBuilder fadeIn() {
    return _copyWith(config: config.copyWith(opacity: 1.0));
  }
  
  /// Fade out animation (opacity 1 to 0)
  AnimatedWidgetBuilder fadeOut() {
    return _copyWith(config: config.copyWith(opacity: 0.0));
  }
  
  /// Set custom opacity
  AnimatedWidgetBuilder opacity(double value) {
    return _copyWith(config: config.copyWith(opacity: value.clamp(0.0, 1.0)));
  }
  
  /// Slide on X axis
  AnimatedWidgetBuilder slideX(double value) {
    return _copyWith(config: config.copyWith(translateX: value));
  }
  
  /// Slide on Y axis
  AnimatedWidgetBuilder slideY(double value) {
    return _copyWith(config: config.copyWith(translateY: value));
  }
  
  /// Slide in from top
  AnimatedWidgetBuilder slideInTop() {
    return _copyWith(config: config.copyWith(slideIn: SlideDirection.top));
  }
  
  /// Slide in from bottom
  AnimatedWidgetBuilder slideInBottom() {
    return _copyWith(config: config.copyWith(slideIn: SlideDirection.bottom));
  }
  
  /// Slide in from left
  AnimatedWidgetBuilder slideInLeft() {
    return _copyWith(config: config.copyWith(slideIn: SlideDirection.left));
  }
  
  /// Slide in from right
  AnimatedWidgetBuilder slideInRight() {
    return _copyWith(config: config.copyWith(slideIn: SlideDirection.right));
  }
  
  /// Rotate animation (in degrees)
  AnimatedWidgetBuilder rotate(double degrees) {
    return _copyWith(config: config.copyWith(rotate: degrees));
  }
  
  /// Combine fade in and scale
  AnimatedWidgetBuilder fadeInScale(double scaleValue) {
    return _copyWith(config: config.copyWith(
      opacity: 1.0,
      scale: scaleValue,
    ));
  }
  
  /// Bounce animation
  AnimatedWidgetBuilder bounce() {
    return _copyWith(config: config.copyWith(bounce: true));
  }
  
  /// Pulse animation
  AnimatedWidgetBuilder pulse() {
    return _copyWith(config: config.copyWith(pulse: true));
  }
  
  /// Animation duration
  /// Accepts Duration, DurationShorthand, or String (e.g., ".500ms", ".5s", ".5m")
  AnimatedWidgetBuilder duration(dynamic durationValue) {
    Duration duration;
    if (durationValue is Duration) {
      duration = durationValue;
    } else if (durationValue is DurationShorthand) {
      duration = durationValue.duration;
    } else if (durationValue is String) {
      duration = DurationShorthand.parse(durationValue).duration;
    } else {
      throw ArgumentError('duration must be Duration, DurationShorthand, or String');
    }
    return _copyWith(config: config.copyWith(duration: duration));
  }
  
  /// Animation delay
  /// Accepts Duration, DurationShorthand, or String (e.g., ".500ms", ".5s", ".5m")
  AnimatedWidgetBuilder delay(dynamic delayValue) {
    Duration delay;
    if (delayValue is Duration) {
      delay = delayValue;
    } else if (delayValue is DurationShorthand) {
      delay = delayValue.duration;
    } else if (delayValue is String) {
      delay = DurationShorthand.parse(delayValue).duration;
    } else {
      throw ArgumentError('delay must be Duration, DurationShorthand, or String');
    }
    return _copyWith(config: config.copyWith(delay: delay));
  }
  
  /// Animation curve
  AnimatedWidgetBuilder curve(Curve curve) {
    return _copyWith(config: config.copyWith(curve: curve));
  }
  
  /// Repeat animation
  AnimatedWidgetBuilder repeat({bool reverse = false}) {
    return _copyWith(config: config.copyWith(repeat: true, reverse: reverse));
  }
  
  /// Repeat animation specific number of times
  AnimatedWidgetBuilder repeatCount(int count, {bool reverse = false}) {
    return _copyWith(config: config.copyWith(
      repeat: false, // Don't set repeat to true when using repeatCount
      repeatCount: count,
      reverse: reverse,
    ));
  }
  
  /// Keep animation state (don't reset on rebuild)
  AnimatedWidgetBuilder persist() {
    return _copyWith(config: config.copyWith(persist: true));
  }
  
  /// Use spring physics animation
  /// Example: .spring(mass: 1.0, stiffness: 500.0, damping: 15.0)
  AnimatedWidgetBuilder spring({
    double mass = 1.0,
    double stiffness = 500.0,
    double damping = 15.0,
    double? initialVelocity,
  }) {
    return _copyWith(
      config: config.copyWith(
        useSpring: true,
        spring: SpringDescription(mass: mass, stiffness: stiffness, damping: damping),
        springInitialVelocity: initialVelocity ?? 0.0,
      ),
    );
  }
  
  /// iOS-style spring animation (snappy with less bounce)
  AnimatedWidgetBuilder springIOS({double? initialVelocity}) {
    return spring(
      mass: 1.2,
      stiffness: 500.0,
      damping: 15.0,
      initialVelocity: initialVelocity,
    );
  }
  
  /// Gentle spring animation (smooth with more bounce)
  AnimatedWidgetBuilder springGentle({double? initialVelocity}) {
    return spring(
      mass: 1.0,
      stiffness: 180.0,
      damping: 24.0,
      initialVelocity: initialVelocity,
    );
  }
  
  /// Bouncy spring animation (high bounce)
  AnimatedWidgetBuilder springBouncy({double? initialVelocity}) {
    return spring(
      mass: 1.0,
      stiffness: 250.0,
      damping: 10.0,
      initialVelocity: initialVelocity,
    );
  }
  
}

/// Internal widget that wraps the child with animation
/// This widget manages its own AnimationController internally
class _AnimatedWidgetWrapper extends StatefulWidget {
  final Widget child;
  final AnimationConfig config;
  
  const _AnimatedWidgetWrapper({
    required this.child,
    required this.config,
  });
  
  @override
  State<_AnimatedWidgetWrapper> createState() => _AnimatedWidgetWrapperState();
}

/// Internal state that manages animation controller
/// Uses TickerProviderStateMixin to support multiple animations if needed
class _AnimatedWidgetWrapperState extends State<_AnimatedWidgetWrapper>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _initialized = false;
  bool _animationStarted = false;
  final GlobalKey _key = GlobalKey();
  void Function(AnimationStatus)? _repeatCountStatusListener;
  
  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    // Check visibility after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibilityAndStart();
    });
  }
  
  void _initializeAnimation() {
    final config = widget.config;
    
    if (config.useSpring && config.spring != null) {
      // Use unbounded controller for spring animations
      _controller = AnimationController.unbounded(
        vsync: this,
      );
      _animation = _controller;
    } else {
      // Use bounded controller for regular animations
    _controller = AnimationController(
      duration: config.duration,
        vsync: this,
    );
    // Apply curve
    _animation = CurvedAnimation(
      parent: _controller,
      curve: config.curve,
    );
    }
    
    _initialized = true;
  }
  
  /// Check if widget is visible in viewport
  bool _isVisibleInViewport() {
    final BuildContext? context = _key.currentContext;
    if (context == null) return false;
    
    final RenderObject? renderObject = context.findRenderObject();
    if (renderObject == null) return false;
    
    if (!renderObject.attached) return false;
    
    final RenderBox? renderBox = renderObject as RenderBox?;
    if (renderBox == null) return false;
    
    try {
      final Offset position = renderBox.localToGlobal(Offset.zero);
      final Size size = renderBox.size;
      
      // Get viewport size from MediaQuery or View
      Size? screenSize;
      try {
        screenSize = MediaQuery.maybeOf(context)?.size;
      } catch (e) {
        // Fallback if MediaQuery not available
      }
      
      if (screenSize == null) {
        // Try to get from View
        try {
          final view = View.of(context);
          screenSize = view.physicalSize / view.devicePixelRatio;
        } catch (e) {
          // If we can't determine screen size, assume visible
          return true;
        }
      }
      
      // Check if widget is within viewport bounds
      // Add some margin to trigger animation slightly before fully visible
      const double margin = 100.0;
      final bool isVisible = position.dx + size.width + margin >= 0 &&
          position.dx - margin <= screenSize.width &&
          position.dy + size.height + margin >= 0 &&
          position.dy - margin <= screenSize.height;
      
      return isVisible;
    } catch (e) {
      // If we can't determine visibility, assume visible to avoid blocking animations
      return true;
    }
  }
  
  /// Check visibility and start animation if visible
  void _checkVisibilityAndStart() {
    if (!mounted || _animationStarted) return;
    
    if (_isVisibleInViewport()) {
      _startAnimation();
      _animationStarted = true;
    } else {
      // Schedule another check
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkVisibilityAndStart();
      });
    }
  }
  
  void _startAnimation() {
    if (_animationStarted) return; // Prevent multiple starts
    
    final config = widget.config;
    
    // Handle delay
    if (config.delay.inMilliseconds > 0) {
      _controller.value = 0.0;
      Future.delayed(config.delay, () {
        if (mounted && !_animationStarted) {
          _animationStarted = true;
          _executeAnimation();
        }
      });
    } else {
      _executeAnimation();
    }
  }
  
  void _executeAnimation() {
    if (!mounted) return;
    
    final config = widget.config;
    
    if (config.useSpring && config.spring != null) {
      // Use spring simulation
      final spring = config.spring!;
      final initialVelocity = config.springInitialVelocity ?? 0.0;
      
      // Determine start and end values based on animation type
      double startValue = 0.0;
      double endValue = 1.0;
      
      // Adjust based on what's being animated
      if (config.scale != null) {
        startValue = 1.0;
        endValue = config.scale!;
      } else if (config.opacity != null) {
        startValue = config.opacity == 0.0 ? 1.0 : 0.0;
        endValue = config.opacity!;
      }
      
      final simulation = SpringSimulation(
        spring,
        startValue,
        endValue,
        initialVelocity,
      );
      _controller.animateWith(simulation);
    } else {
    // Handle repeat - check repeatCount first before infinite repeat
    if (config.repeatCount != null && config.repeatCount! > 1) {
      // Custom repeat count logic
      _setupRepeatCount(config.repeatCount!);
    } else if (config.repeat) {
      _controller.repeat(reverse: config.reverse);
    } else {
      // Single animation forward
      _controller.forward();
      }
    }
  }
  
  void _setupRepeatCount(int count) {
    int currentCount = 0;
    
    void onStatusChange(AnimationStatus status) {
      if (!mounted) return;
      
      if (widget.config.reverse) {
        // For reverse animations, count each complete cycle (forward + reverse = 1)
      if (status == AnimationStatus.completed) {
          // Forward completed, now reverse
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // Reverse completed, one full cycle done
        currentCount++;
        if (currentCount < count) {
            _controller.forward();
          } else {
            // Reached the count, remove listener
            _controller.removeStatusListener(_repeatCountStatusListener!);
            _repeatCountStatusListener = null;
          }
        }
      } else {
        // For non-reverse animations, count each forward completion
        if (status == AnimationStatus.completed) {
        currentCount++;
        if (currentCount < count) {
            _controller.reset();
          _controller.forward();
          } else {
            // Reached the count, remove listener
            _controller.removeStatusListener(_repeatCountStatusListener!);
            _repeatCountStatusListener = null;
          }
        }
      }
    }
    
    _repeatCountStatusListener = onStatusChange;
    _controller.addStatusListener(_repeatCountStatusListener!);
    
    // Start the animation
    _controller.forward();
  }
  
  @override
  void didUpdateWidget(_AnimatedWidgetWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Only reinitialize if config changed and persist is false
    if (!widget.config.persist && oldWidget.config != widget.config) {
      // Stop and dispose the old controller
      _controller.stop();
      _controller.dispose();
      // Reset initialization flag
      _initialized = false;
      _animationStarted = false;
      // Create new animation
      _initializeAnimation();
      // Check visibility again
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkVisibilityAndStart();
      });
    } else if (!_animationStarted) {
      // If animation hasn't started yet, check visibility again
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkVisibilityAndStart();
      });
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return KeyedSubtree(
        key: _key,
        child: widget.child,
      );
    }
    
    // Check visibility on each build if animation hasn't started
    // Also set up scroll listener for scrollable widgets
    if (!_animationStarted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkVisibilityAndStart();
        _setupScrollListener();
      });
    }
    
    return KeyedSubtree(
      key: _key,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return _applyTransforms(child!);
        },
        child: widget.child,
      ),
    );
  }
  
  ScrollableState? _scrollable;
  
  /// Set up scroll listener to check visibility when scrolling
  void _setupScrollListener() {
    if (_animationStarted) return;
    
    final BuildContext? context = _key.currentContext;
    if (context == null) return;
    
    // Find nearest Scrollable
    _scrollable = Scrollable.maybeOf(context);
    if (_scrollable != null) {
      try {
        _scrollable!.position.addListener(_onScroll);
      } catch (e) {
        // Ignore if listener can't be added
      }
    }
  }
  
  void _onScroll() {
    if (!_animationStarted && mounted) {
      _checkVisibilityAndStart();
    }
  }
  
  @override
  void dispose() {
    // Remove scroll listener if it was added
    if (_scrollable != null) {
      try {
        _scrollable!.position.removeListener(_onScroll);
      } catch (e) {
        // Ignore errors if scrollable is already disposed
      }
    }
    // Remove repeat count status listener if it was added
    if (_repeatCountStatusListener != null) {
      try {
        _controller.removeStatusListener(_repeatCountStatusListener!);
      } catch (e) {
        // Ignore errors if controller is already disposed
      }
    }
    _controller.dispose();
    super.dispose();
  }
  
  Widget _applyTransforms(Widget child) {
    final config = widget.config;
    double animationValue = _animation.value;
    
    // Handle special animations
    if (config.bounce) {
      animationValue = _bounceCurve(animationValue);
    } else if (config.pulse) {
      animationValue = _pulseCurve(animationValue);
    }
    
    // Apply transforms
    Widget result = child;
    
    // Opacity - fade in starts from 0, fade out starts from 1
    if (config.opacity != null) {
      final targetOpacity = config.opacity!;
      // If target is 1.0 (fadeIn), animate from 0 to 1
      // If target is 0.0 (fadeOut), animate from 1 to 0
      // For other values, assume fade in from 0
      final startOpacity = (targetOpacity == 0.0) ? 1.0 : 0.0;
      final currentOpacity = startOpacity + (targetOpacity - startOpacity) * animationValue;
      result = Opacity(
        opacity: currentOpacity.clamp(0.0, 1.0),
        child: result,
      );
    }
    
    // Scale - animate from 1.0 to target
    double finalScale = 1.0;
    
    if (config.scale != null) {
      finalScale = 1.0 + (config.scale! - 1.0) * animationValue;
      result = Transform.scale(
        scale: finalScale,
        child: result,
      );
    } else {
      // Separate X and Y scaling
      double scaleX = 1.0;
      double scaleY = 1.0;
      bool hasScale = false;
      
      if (config.scaleX != null) {
        scaleX = 1.0 + (config.scaleX! - 1.0) * animationValue;
        hasScale = true;
      }
      if (config.scaleY != null) {
        scaleY = 1.0 + (config.scaleY! - 1.0) * animationValue;
        hasScale = true;
      }
      
      if (hasScale) {
        result = Transform(
          transform: Matrix4.diagonal3Values(scaleX, scaleY, 1.0),
          alignment: Alignment.center,
          child: result,
        );
      }
    }
    
    // Rotation
    if (config.rotate != null) {
      final rotation = (config.rotate! * animationValue * math.pi) / 180.0;
      result = Transform.rotate(
        angle: rotation,
        child: result,
      );
    }
    
    // Translation
    Offset translation = Offset.zero;
    if (config.translate != null) {
      translation = Offset(
        config.translate!.dx * animationValue,
        config.translate!.dy * animationValue,
      );
    } else {
      if (config.translateX != null) {
        translation = Offset(
          config.translateX! * animationValue,
          translation.dy,
        );
      }
      if (config.translateY != null) {
        translation = Offset(
          translation.dx,
          config.translateY! * animationValue,
        );
      }
    }
    
    // Slide in from directions - start outside, animate in
    if (config.slideIn != null) {
      final size = MediaQuery.maybeOf(context)?.size ?? const Size(100, 100);
      Offset slideOffset = Offset.zero;
      
      switch (config.slideIn!) {
        case SlideDirection.top:
          slideOffset = Offset(0, -size.height * (1 - animationValue));
          break;
        case SlideDirection.bottom:
          slideOffset = Offset(0, size.height * (1 - animationValue));
          break;
        case SlideDirection.left:
          slideOffset = Offset(-size.width * (1 - animationValue), 0);
          break;
        case SlideDirection.right:
          slideOffset = Offset(size.width * (1 - animationValue), 0);
          break;
      }
      
      translation = translation + slideOffset;
    }
    
    if (translation != Offset.zero) {
      result = Transform.translate(
        offset: translation,
        child: result,
      );
    }
    
    return result;
  }
  
  /// Bounce curve effect
  double _bounceCurve(double t) {
    if (t < 1.0 / 2.75) {
      return 7.5625 * t * t;
    } else if (t < 2.0 / 2.75) {
      final adjustedT = t - 1.5 / 2.75;
      return 7.5625 * adjustedT * adjustedT + 0.75;
    } else if (t < 2.5 / 2.75) {
      final adjustedT = t - 2.25 / 2.75;
      return 7.5625 * adjustedT * adjustedT + 0.9375;
    } else {
      final adjustedT = t - 2.625 / 2.75;
      return 7.5625 * adjustedT * adjustedT + 0.984375;
    }
  }
  
  /// Pulse curve effect (ease in-out with emphasis)
  double _pulseCurve(double t) {
    return t < 0.5
        ? 4 * t * t * t
        : 1 - math.pow(-2 * t + 2, 3) / 2;
  }
}

