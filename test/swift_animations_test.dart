import 'package:flutter_test/flutter_test.dart';
import 'package:swift_animations/swift_animations.dart';
import 'package:flutter/material.dart';

void main() {
  group('Swift Animations', () {
    test('AnimateExtension should return AnimatedWidgetBuilder', () {
      final widget = Container();
      final animated = widget.animate();
      expect(animated, isA<AnimatedWidgetBuilder>());
    });

    test('DurationShorthand should parse milliseconds', () {
      final duration = DurationShorthand.parse('500ms');
      expect(duration.duration, const Duration(milliseconds: 500));
    });

    test('DurationShorthand should parse seconds', () {
      final duration = DurationShorthand.parse('1.5s');
      expect(duration.duration, const Duration(milliseconds: 1500));
    });

    test('DurationShorthand should parse minutes', () {
      final duration = DurationShorthand.parse('2m');
      expect(duration.duration, const Duration(minutes: 2));
    });

    test('Number extension should create duration shorthand', () {
      expect(500.ms.duration, const Duration(milliseconds: 500));
      expect(1.5.s.duration, const Duration(milliseconds: 1500));
      expect(2.m.duration, const Duration(minutes: 2));
    });

    test('AnimationConfig should copy with new values', () {
      final config = AnimationConfig(
        scale: 1.0,
        duration: const Duration(seconds: 1),
      );
      final newConfig = config.copyWith(scale: 2.0);
      expect(newConfig.scale, 2.0);
      expect(newConfig.duration, const Duration(seconds: 1));
    });

    test('AnimatedWidgetBuilder should chain methods', () {
      final widget = Container();
      final animated = widget
          .animate()
          .fadeIn()
          .scale(1.5)
          .duration(500.ms);
      
      expect(animated, isA<AnimatedWidgetBuilder>());
    });
  });
}

