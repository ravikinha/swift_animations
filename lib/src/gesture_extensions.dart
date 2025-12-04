import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'dart:async';
import 'dart:math' as math;

/// Extension to add liquid tap effects to any widget using swift_animations
/// 
/// Similar to swift_liquid's `.sGestureDetector()`, but uses swift_animations
/// for the animation system with spring physics.
/// 
/// Example:
/// ```dart
/// Container(
///   width: 100,
///   height: 100,
///   color: Colors.blue,
/// )
/// .sGestureDetector(
///   onPressed: () => print('Tapped'),
///   onLongPress: () => print('Long pressed'),
/// )
/// ```
extension WidgetGestureExtensions on Widget {
  /// Add liquid tap effects to any widget
  /// 
  /// Wraps the widget with gesture detection and spring animations to provide:
  /// - Scale animation on tap with spring physics
  /// - Stretch effects during drag
  /// - Spring physics animations (using swift_animations spring system)
  /// - Long press support
  /// 
  /// Uses swift_animations spring physics for smooth, iOS-style animations.
  Widget sGestureDetector({
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    double scaleOnPress = 1.1,
    Duration longPressDuration = const Duration(milliseconds: 500),
    bool autoScaleBySize = true,
    double basePixelIncrease = 10.0,
    double stretchSpringDamping = 10.0,
    double stretchSensitivity = 1.0,
    double translateSensitivity = 1.0,
    bool enableBrightness = false,
  }) {
    return _GestureDetectorWrapper(
      onPressed: onPressed,
      onLongPress: onLongPress,
      scaleOnPress: scaleOnPress,
      longPressDuration: longPressDuration,
      autoScaleBySize: autoScaleBySize,
      basePixelIncrease: basePixelIncrease,
      stretchSpringDamping: stretchSpringDamping,
      stretchSensitivity: stretchSensitivity,
      translateSensitivity: translateSensitivity,
      enableBrightness: enableBrightness,
      child: this,
    );
  }
}

/// Internal widget that handles gesture detection and spring animations
class _GestureDetectorWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final double scaleOnPress;
  final Duration longPressDuration;
  final bool autoScaleBySize;
  final double basePixelIncrease;
  final double stretchSpringDamping;
  final double stretchSensitivity;
  final double translateSensitivity;
  final bool enableBrightness;

  const _GestureDetectorWrapper({
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.scaleOnPress = 1.1,
    this.longPressDuration = const Duration(milliseconds: 500),
    this.autoScaleBySize = true,
    this.basePixelIncrease = 10.0,
    this.stretchSpringDamping = 10.0,
    this.stretchSensitivity = 1.0,
    this.translateSensitivity = 1.0,
    this.enableBrightness = false,
  });

  @override
  State<_GestureDetectorWrapper> createState() => _GestureDetectorWrapperState();
}

class _GestureDetectorWrapperState extends State<_GestureDetectorWrapper>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _stretchXController;
  late AnimationController _stretchYController;
  late AnimationController _offsetXController;
  late AnimationController _offsetYController;
  
  double _scale = 1.0;
  double _stretchX = 1.0;
  double _stretchY = 1.0;
  double _offsetX = 0.0;
  double _offsetY = 0.0;
  
  Timer? _longPressTimer;
  bool _isDisposed = false;
  Offset? _initialPosition;
  bool _isPointerInside = false;

  // Spring configurations matching swift_animations springIOS style
  static const SpringDescription _tapDownSpring = SpringDescription(
    mass: 1.2,
    stiffness: 500.0,
    damping: 15.0,
  );
  
  static const SpringDescription _tapReleaseSpring = SpringDescription(
    mass: 1.0,
    stiffness: 180.0,
    damping: 24.0,
  );

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController.unbounded(vsync: this);
    _stretchXController = AnimationController.unbounded(vsync: this);
    _stretchYController = AnimationController.unbounded(vsync: this);
    _offsetXController = AnimationController.unbounded(vsync: this);
    _offsetYController = AnimationController.unbounded(vsync: this);
  }

  @override
  void dispose() {
    _isDisposed = true;
    _longPressTimer?.cancel();
    _scaleController.dispose();
    _stretchXController.dispose();
    _stretchYController.dispose();
    _offsetXController.dispose();
    _offsetYController.dispose();
    super.dispose();
  }

  void _handlePointerDown(PointerDownEvent event) {
    if (_isDisposed) return;
    
    _initialPosition = event.localPosition;
    _isPointerInside = true;
    
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    
    final size = renderBox.size;
    double targetScale = widget.scaleOnPress;
    
    if (widget.autoScaleBySize) {
      final hypotenuse = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
      targetScale = 1.0 + (widget.basePixelIncrease / hypotenuse);
    }
    
    // Spring animation for tap down
    final simulation = SpringSimulation(
      _tapDownSpring,
      _scale,
      targetScale,
      0.0,
    );
    _scaleController.animateWith(simulation);
    
    setState(() {
      _scale = targetScale;
    });
    
    // Start long press timer
    if (widget.onLongPress != null) {
      _longPressTimer = Timer(widget.longPressDuration, () {
        if (!_isDisposed) {
          widget.onLongPress?.call();
        }
      });
    }
  }

  void _handlePointerMove(PointerMoveEvent event) {
    if (_isDisposed || _initialPosition == null) return;
    
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    
    final position = event.localPosition;
    final size = renderBox.size;
    _isPointerInside = position.dx >= 0 && 
                       position.dx <= size.width && 
                       position.dy >= 0 && 
                       position.dy <= size.height;
    
    final newOffset = position - _initialPosition!;
    
    // Liquid glass effect: stretch in the direction of movement
    const baseStretchFactor = 5000.0;
    const baseMaxStretch = 0.15;
    const baseTranslateFactor = 0.02;
    
    final stretchFactor = baseStretchFactor / widget.stretchSensitivity;
    final maxStretch = baseMaxStretch * widget.stretchSensitivity;
    final translateFactor = baseTranslateFactor * widget.translateSensitivity;
    
    final rawStretchX = (newOffset.dx.abs() / stretchFactor).clamp(0.0, maxStretch);
    final rawStretchY = (newOffset.dy.abs() / stretchFactor).clamp(0.0, maxStretch);
    
    // Area conservation: stretch in one direction, compress in the other
    final diff = rawStretchX - rawStretchY;
    final stretchX = 1.0 + diff.clamp(-maxStretch, maxStretch);
    final stretchY = 1.0 - diff.clamp(-maxStretch, maxStretch);
    
    final translateX = newOffset.dx * translateFactor;
    final translateY = newOffset.dy * translateFactor;
    
    // Animate stretch with spring
    final stretchSpring = SpringDescription(
      mass: 1.0,
      stiffness: 250.0,
      damping: widget.stretchSpringDamping,
    );
    
    _stretchXController.animateWith(
      SpringSimulation(stretchSpring, _stretchX, stretchX, 0.0),
    );
    _stretchYController.animateWith(
      SpringSimulation(stretchSpring, _stretchY, stretchY, 0.0),
    );
    _offsetXController.animateWith(
      SpringSimulation(stretchSpring, _offsetX, translateX, 0.0),
    );
    _offsetYController.animateWith(
      SpringSimulation(stretchSpring, _offsetY, translateY, 0.0),
    );
    
    setState(() {
      _stretchX = stretchX;
      _stretchY = stretchY;
      _offsetX = translateX;
      _offsetY = translateY;
    });
  }

  void _handlePointerUp(PointerUpEvent event) {
    if (_isDisposed) return;
    
    _longPressTimer?.cancel();
    _longPressTimer = null;
    
    // Spring animation for release
    final simulation = SpringSimulation(
      _tapReleaseSpring,
      _scale,
      1.0,
      0.0,
    );
    _scaleController.animateWith(simulation);
    
    // Reset stretch and offset
    final stretchSpring = SpringDescription(
      mass: 1.0,
      stiffness: 250.0,
      damping: widget.stretchSpringDamping,
    );
    
    _stretchXController.animateWith(
      SpringSimulation(stretchSpring, _stretchX, 1.0, 0.0),
    );
    _stretchYController.animateWith(
      SpringSimulation(stretchSpring, _stretchY, 1.0, 0.0),
    );
    _offsetXController.animateWith(
      SpringSimulation(stretchSpring, _offsetX, 0.0, 0.0),
    );
    _offsetYController.animateWith(
      SpringSimulation(stretchSpring, _offsetY, 0.0, 0.0),
    );
    
    setState(() {
      _scale = 1.0;
      _stretchX = 1.0;
      _stretchY = 1.0;
      _offsetX = 0.0;
      _offsetY = 0.0;
      _initialPosition = null;
    });
    
    if (_isPointerInside) {
      widget.onPressed?.call();
    }
  }

  void _handlePointerCancel(PointerCancelEvent event) {
    // Reset to initial state on cancel
    _longPressTimer?.cancel();
    _longPressTimer = null;
    
    // Spring animation for release
    final simulation = SpringSimulation(
      _tapReleaseSpring,
      _scale,
      1.0,
      0.0,
    );
    _scaleController.animateWith(simulation);
    
    // Reset stretch and offset
    final stretchSpring = SpringDescription(
      mass: 1.0,
      stiffness: 250.0,
      damping: widget.stretchSpringDamping,
    );
    
    _stretchXController.animateWith(
      SpringSimulation(stretchSpring, _stretchX, 1.0, 0.0),
    );
    _stretchYController.animateWith(
      SpringSimulation(stretchSpring, _stretchY, 1.0, 0.0),
    );
    _offsetXController.animateWith(
      SpringSimulation(stretchSpring, _offsetX, 0.0, 0.0),
    );
    _offsetYController.animateWith(
      SpringSimulation(stretchSpring, _offsetY, 0.0, 0.0),
    );
    
    setState(() {
      _scale = 1.0;
      _stretchX = 1.0;
      _stretchY = 1.0;
      _offsetX = 0.0;
      _offsetY = 0.0;
      _initialPosition = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _handlePointerDown,
      onPointerMove: _handlePointerMove,
      onPointerUp: _handlePointerUp,
      onPointerCancel: _handlePointerCancel,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _scaleController,
          _stretchXController,
          _stretchYController,
          _offsetXController,
          _offsetYController,
        ]),
        builder: (context, child) {
          final scaleX = _scaleController.value * _stretchXController.value;
          final scaleY = _scaleController.value * _stretchYController.value;
          final translateX = _offsetXController.value;
          final translateY = _offsetYController.value;
          
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(0, 3, translateX)
              ..setEntry(1, 3, translateY)
              ..setEntry(0, 0, scaleX)
              ..setEntry(1, 1, scaleY),
            alignment: Alignment.center,
            child: widget.child,
          );
        },
      ),
    );
  }
}
