/// Navigation animations for Flutter
/// 
/// Provides platform-specific navigation animations with a fluent API
/// 
/// ```dart
/// swift.push(route)
///   .ios()
///   .duration(500)
///   .curve(Curves.easeInOut)
///   .go(context);
/// ```
library;

import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

/// Platform detection helper
bool get _isIOS => !kIsWeb && Platform.isIOS;
bool get _isAndroid => !kIsWeb && Platform.isAndroid;

/// Navigation type enum
enum NavigationType {
  push,
  pushReplacement,
  pushRoute,
  pushNamed,
  pushReplacementNamed,
  pushNamedAndRemoveUntil,
  pushAndRemoveUntil,
}

/// Navigation animation configuration
class NavigationAnimationConfig {
  final Duration duration;
  final Curve curve;
  final bool isIOS;
  final bool isAndroid;
  final bool isWeb;
  
  NavigationAnimationConfig({
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    bool? isIOS,
    bool? isAndroid,
    bool? isWeb,
  }) : isIOS = isIOS ?? _isIOS,
       isAndroid = isAndroid ?? _isAndroid,
       isWeb = isWeb ?? kIsWeb;
  
  NavigationAnimationConfig copyWith({
    Duration? duration,
    Curve? curve,
    bool? isIOS,
    bool? isAndroid,
    bool? isWeb,
  }) {
    return NavigationAnimationConfig(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      isIOS: isIOS ?? this.isIOS,
      isAndroid: isAndroid ?? this.isAndroid,
      isWeb: isWeb ?? this.isWeb,
    );
  }
}

/// Navigation animation builder
class NavigationAnimationBuilder {
  final dynamic route;
  final NavigationAnimationConfig config;
  final BuildContext? context;
  final NavigationType navigationType;
  
  NavigationAnimationBuilder(
    this.route, {
    NavigationAnimationConfig? config,
    this.context,
    this.navigationType = NavigationType.push,
  }) : config = config ?? NavigationAnimationConfig();
  
  NavigationAnimationBuilder _copyWith({
    dynamic route,
    NavigationAnimationConfig? config,
    BuildContext? context,
    NavigationType? navigationType,
  }) {
    return NavigationAnimationBuilder(
      route ?? this.route,
      config: config ?? this.config,
      context: context ?? this.context,
      navigationType: navigationType ?? this.navigationType,
    );
  }
  
  /// Set iOS platform
  NavigationAnimationBuilder ios() {
    return _copyWith(
      config: config.copyWith(isIOS: true, isAndroid: false, isWeb: false),
    );
  }
  
  /// Set Android platform
  NavigationAnimationBuilder android() {
    return _copyWith(
      config: config.copyWith(isIOS: false, isAndroid: true, isWeb: false),
    );
  }
  
  /// Set web platform
  NavigationAnimationBuilder web() {
    return _copyWith(
      config: config.copyWith(isIOS: false, isAndroid: false, isWeb: true),
    );
  }
  
  /// Set animation duration
  NavigationAnimationBuilder duration(dynamic durationValue) {
    Duration duration;
    if (durationValue is Duration) {
      duration = durationValue;
    } else if (durationValue is int) {
      duration = Duration(milliseconds: durationValue);
    } else {
      throw ArgumentError('duration must be Duration or int (milliseconds)');
    }
    return _copyWith(config: config.copyWith(duration: duration));
  }
  
  /// Set animation curve
  NavigationAnimationBuilder curve(Curve curve) {
    return _copyWith(config: config.copyWith(curve: curve));
  }
  
  /// Execute navigation based on navigation type
  Future<T?> go<T, TO>(BuildContext context, {
    TO? result,
    bool Function(Route<dynamic>)? predicate,
    Object? arguments,
  }) {
    switch (navigationType) {
      case NavigationType.push:
        return _push<T>(context);
      case NavigationType.pushReplacement:
        return _pushReplacement<T, TO>(context, result: result);
      case NavigationType.pushRoute:
        return _push<T>(context);
      case NavigationType.pushNamed:
        return _pushNamed<T>(context, arguments: arguments);
      case NavigationType.pushReplacementNamed:
        return _pushReplacementNamed<T, TO>(context, result: result, arguments: arguments);
      case NavigationType.pushNamedAndRemoveUntil:
        if (predicate == null) {
          throw ArgumentError('pushNamedAndRemoveUntil requires a predicate');
        }
        return _pushNamedAndRemoveUntil<T>(context, predicate, arguments: arguments);
      case NavigationType.pushAndRemoveUntil:
        if (predicate == null) {
          throw ArgumentError('pushAndRemoveUntil requires a predicate');
        }
        return _pushAndRemoveUntil<T>(context, predicate);
    }
  }
  
  /// Execute push navigation (alias for go)
  Future<T?> push<T extends Object?>(BuildContext context) {
    return _push<T>(context);
  }
  
  Future<T?> _push<T extends Object?>(BuildContext context) {
    final pageRoute = _createPageRoute<T>(route);
    return Navigator.of(context).push<T>(pageRoute);
  }
  
  /// Execute push replacement navigation
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context, {
    TO? result,
  }) {
    return _pushReplacement<T, TO>(context, result: result);
  }
  
  Future<T?> _pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context, {
    TO? result,
  }) {
    final pageRoute = _createPageRoute<T>(route);
    return Navigator.of(context).pushReplacement<T, TO>(
      pageRoute,
      result: result,
    );
  }
  
  /// Execute push and remove until navigation
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    bool Function(Route<dynamic>) predicate,
  ) {
    return _pushAndRemoveUntil<T>(context, predicate);
  }
  
  Future<T?> _pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    bool Function(Route<dynamic>) predicate,
  ) {
    final pageRoute = _createPageRoute<T>(route);
    return Navigator.of(context).pushAndRemoveUntil<T>(
      pageRoute,
      predicate,
    );
  }
  
  /// Execute push named navigation
  Future<T?> pushNamed<T extends Object?>(
    BuildContext context, {
    Object? arguments,
  }) {
    return _pushNamed<T>(context, arguments: arguments);
  }
  
  Future<T?> _pushNamed<T extends Object?>(
    BuildContext context, {
    Object? arguments,
  }) {
    if (route is! String) {
      throw ArgumentError('pushNamed requires a String route');
    }
    return Navigator.of(context).pushNamed<T>(
      route as String,
      arguments: arguments,
    );
  }
  
  /// Execute push replacement named navigation
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    BuildContext context, {
    TO? result,
    Object? arguments,
  }) {
    return _pushReplacementNamed<T, TO>(context, result: result, arguments: arguments);
  }
  
  Future<T?> _pushReplacementNamed<T extends Object?, TO extends Object?>(
    BuildContext context, {
    TO? result,
    Object? arguments,
  }) {
    if (route is! String) {
      throw ArgumentError('pushReplacementNamed requires a String route');
    }
    return Navigator.of(context).pushReplacementNamed<T, TO>(
      route as String,
      result: result,
      arguments: arguments,
    );
  }
  
  /// Execute push named and remove until navigation
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    BuildContext context,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return _pushNamedAndRemoveUntil<T>(context, predicate, arguments: arguments);
  }
  
  Future<T?> _pushNamedAndRemoveUntil<T extends Object?>(
    BuildContext context,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    if (route is! String) {
      throw ArgumentError('pushNamedAndRemoveUntil requires a String route');
    }
    return Navigator.of(context).pushNamedAndRemoveUntil<T>(
      route as String,
      predicate,
      arguments: arguments,
    );
  }
  
  /// Create page route with platform-specific transitions
  PageRoute<T> _createPageRoute<T extends Object?>(dynamic route) {
    Widget page;
    
    if (route is Widget) {
      page = route;
    } else if (route is PageRoute) {
      // If it's already a PageRoute, return it as-is
      return route as PageRoute<T>;
    } else if (route is Route) {
      // Convert Route to PageRoute if possible
      throw ArgumentError(
        'Route objects are not directly supported. Use a Widget or PageRoute instead.',
      );
    } else if (route is String) {
      // For named routes, we need to get the route from settings
      // This is a simplified version - in practice, you'd use your routing setup
      throw UnimplementedError(
        'Named routes require a route builder. Use pushNamed() instead.',
      );
    } else if (route is RouteSettings) {
      throw UnimplementedError(
        'RouteSettings require a route builder. Use pushNamed() instead.',
      );
    } else {
      throw ArgumentError('Route must be a Widget, PageRoute, String, or RouteSettings');
    }
    
    if (config.isIOS) {
      return _createIOSPageRoute<T>(page);
    } else if (config.isAndroid) {
      return _createAndroidPageRoute<T>(page);
    } else {
      // Default/Web transition
      return _createDefaultPageRoute<T>(page);
    }
  }
  
  /// Create iOS-style page route (slide from right)
  PageRoute<T> _createIOSPageRoute<T extends Object?>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: config.duration,
      reverseTransitionDuration: config.duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: config.curve),
        );
        
        var offsetAnimation = animation.drive(tween);
        
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
  
  /// Create Android-style page route (fade + slide up)
  PageRoute<T> _createAndroidPageRoute<T extends Object?>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: config.duration,
      reverseTransitionDuration: config.duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.1);
        const end = Offset.zero;
        
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: config.curve),
        );
        
        var offsetAnimation = animation.drive(tween);
        var fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: config.curve,
        );
        
        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: offsetAnimation,
            child: child,
          ),
        );
      },
    );
  }
  
  /// Create default page route (fade transition)
  PageRoute<T> _createDefaultPageRoute<T extends Object?>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: config.duration,
      reverseTransitionDuration: config.duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: config.curve,
          ),
          child: child,
        );
      },
    );
  }
}

/// Swift navigation singleton
class SwiftNavigation {
  static final SwiftNavigation _instance = SwiftNavigation._internal();
  factory SwiftNavigation() => _instance;
  SwiftNavigation._internal();
  
  /// Push navigation
  NavigationAnimationBuilder push(dynamic route) {
    return NavigationAnimationBuilder(
      route,
      navigationType: NavigationType.push,
    );
  }
  
  /// Push replacement navigation
  NavigationAnimationBuilder pushReplacement(dynamic route) {
    return NavigationAnimationBuilder(
      route,
      navigationType: NavigationType.pushReplacement,
    );
  }
  
  /// Push route navigation
  NavigationAnimationBuilder pushRoute(dynamic route) {
    return NavigationAnimationBuilder(
      route,
      navigationType: NavigationType.pushRoute,
    );
  }
  
  /// Push named navigation
  NavigationAnimationBuilder pushNamed(String routeName) {
    return NavigationAnimationBuilder(
      routeName,
      navigationType: NavigationType.pushNamed,
    );
  }
  
  /// Push replacement named navigation
  NavigationAnimationBuilder pushReplacementNamed(String routeName) {
    return NavigationAnimationBuilder(
      routeName,
      navigationType: NavigationType.pushReplacementNamed,
    );
  }
  
  /// Push named and remove until navigation
  NavigationAnimationBuilder pushNamedAndRemoveUntil(String routeName) {
    return NavigationAnimationBuilder(
      routeName,
      navigationType: NavigationType.pushNamedAndRemoveUntil,
    );
  }
  
  /// Push and remove until navigation
  NavigationAnimationBuilder pushAndRemoveUntil(dynamic route) {
    return NavigationAnimationBuilder(
      route,
      navigationType: NavigationType.pushAndRemoveUntil,
    );
  }
}

/// Global swift navigation instance
final swift = SwiftNavigation();

