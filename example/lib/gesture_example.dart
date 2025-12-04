import 'package:flutter/material.dart';
import 'package:swift_animations/swift_animations.dart';

class GestureExample extends StatefulWidget {
  const GestureExample({super.key});

  @override
  State<GestureExample> createState() => _GestureExampleState();
}

class _GestureExampleState extends State<GestureExample> {
  int _tapCount = 0;
  int _longPressCount = 0;
  String _lastAction = 'None';

  void _showFeedback(String message) {
    setState(() {
      _lastAction = message;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture Extension Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'sGestureDetector() Extension',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Add liquid tap effects to any widget using .sGestureDetector() extension',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            // Status Card
            Card(
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Taps: $_tapCount'),
                    Text('Long Presses: $_longPressCount'),
                    Text('Last Action: $_lastAction'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            _buildExample(
              context,
              'Basic Tap',
              'Simple tap with liquid scale effect',
              Colors.blue,
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.touch_app, color: Colors.white, size: 48),
              ).sGestureDetector(
                onPressed: () {
                  setState(() => _tapCount++);
                  _showFeedback('Basic tap detected!');
                },
              ),
            ),
            const SizedBox(height: 24),
            _buildExample(
              context,
              'Long Press',
              'Hold for 500ms to trigger long press',
              Colors.purple,
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.timer, color: Colors.white, size: 48),
              ).sGestureDetector(
                onPressed: () {
                  setState(() => _tapCount++);
                  _showFeedback('Quick tap');
                },
                onLongPress: () {
                  setState(() => _longPressCount++);
                  _showFeedback('Long press triggered!');
                },
                longPressDuration: const Duration(milliseconds: 500),
              ),
            ),
            const SizedBox(height: 24),
            _buildExample(
              context,
              'Drag & Stretch',
              'Tap and drag to see stretch effects',
              Colors.teal,
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.open_with, color: Colors.white, size: 48),
              ).sGestureDetector(
                onPressed: () {
                  setState(() => _tapCount++);
                  _showFeedback('Released after drag');
                },
                stretchSensitivity: 2.0,
                translateSensitivity: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            _buildExample(
              context,
              'High Sensitivity',
              'Very responsive to drag movements',
              Colors.red,
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.bolt, color: Colors.white, size: 48),
              ).sGestureDetector(
                onPressed: () {
                  setState(() => _tapCount++);
                  _showFeedback('High sensitivity tap');
                },
                stretchSensitivity: 3.0,
                translateSensitivity: 2.0,
                stretchSpringDamping: 8.0,
              ),
            ),
            const SizedBox(height: 24),
            _buildExample(
              context,
              'Low Sensitivity',
              'Less responsive, smoother',
              Colors.indigo,
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.tune, color: Colors.white, size: 48),
              ).sGestureDetector(
                onPressed: () {
                  setState(() => _tapCount++);
                  _showFeedback('Low sensitivity tap');
                },
                stretchSensitivity: 0.5,
                translateSensitivity: 0.5,
                stretchSpringDamping: 20.0,
              ),
            ),
            const SizedBox(height: 24),
            _buildExample(
              context,
              'Text Button',
              'Works on any widget type',
              Colors.green,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Tap Me',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ).sGestureDetector(
                onPressed: () {
                  setState(() => _tapCount++);
                  _showFeedback('Text button tapped!');
                },
              ),
            ),
            const SizedBox(height: 24),
            _buildExample(
              context,
              'Card Widget',
              'Card with liquid effects',
              Colors.pink,
              Card(
                color: Colors.pink,
                child: const Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Card Content',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ).sGestureDetector(
                onPressed: () {
                  setState(() => _tapCount++);
                  _showFeedback('Card tapped!');
                },
                onLongPress: () {
                  setState(() => _longPressCount++);
                  _showFeedback('Card long pressed!');
                },
              ),
            ),
            const SizedBox(height: 24),
            _buildExample(
              context,
              'Icon Widget',
              'Direct icon with extension',
              Colors.cyan,
              const Icon(
                Icons.star,
                size: 80,
                color: Colors.cyan,
              ).sGestureDetector(
                onPressed: () {
                  setState(() => _tapCount++);
                  _showFeedback('Icon tapped!');
                },
                onLongPress: () {
                  setState(() => _longPressCount++);
                  _showFeedback('Icon long pressed!');
                },
              ),
            ),
            const SizedBox(height: 24),
            _buildExample(
              context,
              'Custom Scale',
              'Larger scale on press (1.3x)',
              Colors.amber,
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.zoom_in, color: Colors.white, size: 40),
              ).sGestureDetector(
                onPressed: () {
                  setState(() => _tapCount++);
                  _showFeedback('Custom scale tapped!');
                },
                scaleOnPress: 1.3,
                autoScaleBySize: false,
              ),
            ),
            const SizedBox(height: 24),
            _buildExample(
              context,
              'Combined with Animate',
              'Gesture + declarative animations',
              Colors.deepPurple,
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.animation, color: Colors.white, size: 48),
              )
                .sGestureDetector(
                  onPressed: () {
                    setState(() => _tapCount++);
                    _showFeedback('Animated widget tapped!');
                  },
                )
                .animate()
                .scale(1.1)
                .fadeIn()
                .repeat(reverse: true),
            ),
            const SizedBox(height: 32),
            // Reset button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _tapCount = 0;
                    _longPressCount = 0;
                    _lastAction = 'None';
                  });
                  _showFeedback('Counters reset');
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Counters'),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildExample(
    BuildContext context,
    String title,
    String description,
    Color color,
    Widget child,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 16),
        Center(child: child),
      ],
    );
  }
}

