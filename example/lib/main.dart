import 'package:flutter/material.dart';
import 'package:swift_animations/swift_animations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swift Animations Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnimationExamplesPage(),
    );
  }
}

class AnimationExamplesPage extends StatefulWidget {
  const AnimationExamplesPage({super.key});

  @override
  State<AnimationExamplesPage> createState() => _AnimationExamplesPageState();
}

class _AnimationExamplesPageState extends State<AnimationExamplesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swift Animations Examples'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Scroll to see animations!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Animations only start when widgets come into view',
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          // Fade In Example
          _buildSection(
            title: '1. Fade In',
            description: 'Fades in when visible',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Fade In Animation',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
              .animate()
              .fadeIn()
              .duration(1.s),
          ),
          
          const SizedBox(height: 24),
          
          // Scale Example
          _buildSection(
            title: '2. Scale',
            description: 'Scales up when visible',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Scale Animation',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
              .animate()
              .scale(1.2)
              .duration(1.s)
              .repeat(reverse: true),
          ),
          
          const SizedBox(height: 24),
          
          // Rotate Example
          _buildSection(
            title: '3. Rotate',
            description: 'Rotates when visible',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Rotate Animation',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
              .animate()
              .rotate(360)
              .duration(2.s)
              .repeat(reverse: false),
          ),
          
          const SizedBox(height: 24),
          
          // Bounce Example
          _buildSection(
            title: '4. Bounce',
            description: 'Bounces when visible',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Bounce Animation',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
              .animate()
              .bounce()
              .scale(1.3)
              .duration(1.s)
              .repeat(reverse: true),
          ),
          
          const SizedBox(height: 24),
          
          // Pulse Example
          _buildSection(
            title: '5. Pulse',
            description: 'Pulses when visible',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.favorite,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            )
              .animate()
              .pulse()
              .scale(1.3)
              .duration(0.8.s)
              .repeat(reverse: true),
          ),
          
          const SizedBox(height: 24),
          
          // Slide In Top
          _buildSection(
            title: '6. Slide In Top',
            description: 'Slides from top when visible',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Slide In Top',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
              .animate()
              .slideInTop()
              .fadeIn()
              .duration(0.8.s),
          ),
          
          const SizedBox(height: 24),
          
          // Slide In Left
          _buildSection(
            title: '7. Slide In Left',
            description: 'Slides from left when visible',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Slide In Left',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
              .animate()
              .slideInLeft()
              .fadeIn()
              .duration(0.8.s),
          ),
          
          const SizedBox(height: 24),
          
          // Complex Animation
          _buildSection(
            title: '8. Complex Animation',
            description: 'Multiple animations combined',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Complex Animation',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
              .animate()
              .fadeIn()
              .scale(1.2)
              .slideInBottom()
              .rotate(180)
              .duration(1.5.s)
              .curve(Curves.easeInOut)
              .repeat(reverse: true),
          ),
          
          const SizedBox(height: 24),
          
          // Fade In Scale
          _buildSection(
            title: '9. Fade In Scale',
            description: 'Fades and scales when visible',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Fade In Scale',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
              .animate()
              .fadeInScale(1.2)
              .duration(1.s)
              .repeat(reverse: true),
          ),
          
          const SizedBox(height: 24),
          
          // Delayed Animation
          _buildSection(
            title: '10. Delayed Animation',
            description: 'Starts with delay when visible',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Delayed Animation',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
              .animate()
              .fadeIn()
              .scale(1.3)
              .delay(500.ms)
              .duration(1.s),
          ),
          
          const SizedBox(height: 24),
          
          // Repeat Count
          _buildSection(
            title: '11. Repeat Count (3 times)',
            description: 'Repeats 3 times when visible',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Repeat 3 Times',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
              .animate()
              .scale(1.4)
              .duration(0.6.s)
              .repeatCount(3, reverse: true),
          ),
          
          const SizedBox(height: 24),
          
          // Multiple Cards with Stagger
          _buildSection(
            title: '12. Staggered Animations',
            description: 'Multiple items with different delays',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStaggeredCard(Colors.red, 0),
                _buildStaggeredCard(Colors.green, 200),
                _buildStaggeredCard(Colors.blue, 400),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Slide X and Y
          _buildSection(
            title: '13. Slide X and Y',
            description: 'Custom slide animation',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Slide X and Y',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
              .animate()
              .slideX(50)
              .slideY(30)
              .duration(1.s)
              .repeat(reverse: true),
          ),
          
          const SizedBox(height: 24),
          
          // More items to demonstrate scrolling
          _buildSection(
            title: '14. More Items Below',
            description: 'Keep scrolling to see more animations',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Keep Scrolling!',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
              .animate()
              .fadeIn()
              .slideInBottom()
              .duration(1.s),
          ),
          
          const SizedBox(height: 24),
          
          _buildSection(
            title: '15. Another Animation',
            description: 'Animations trigger as you scroll',
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.lime,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Scroll Triggered',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            )
              .animate()
              .scale(1.2)
              .rotate(90)
              .duration(1.5.s)
              .repeat(reverse: true),
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }
  
  Widget _buildSection({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
  
  Widget _buildStaggeredCard(Color color, int delayMs) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    )
      .animate()
      .fadeIn()
      .scale(1.2)
      .delay(Duration(milliseconds: delayMs))
      .duration(0.5.s)
      .repeat(reverse: true);
  }
}
