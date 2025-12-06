import 'package:flutter/material.dart';
import 'package:swift_animations/swift_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'gesture_example.dart';

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
      routes: {
        '/detail': (context) => const DetailPage(title: 'Named Route Detail'),
        '/home': (context) => const AnimationExamplesPage(),
        '/login': (context) => const DetailPage(title: 'Login Page'),
      },
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
            'Swift Animations Examples',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Animations only start when widgets come into view',
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Buy Me a Coffee Button
          _BuyMeACoffeeCard(),
          const SizedBox(height: 24),
          // Gesture Example Button
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GestureExample(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.touch_app, size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Gesture Extension',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tap to see .sGestureDetector() examples',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Navigation Example Button
          Card(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: InkWell(
              onTap: () {
                swift.push(const NavigationExamplePage())
                  .ios()
                  .duration(500)
                  .curve(Curves.easeInOut)
                  .go(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.navigation, size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Navigation Animations',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tap to see platform-specific navigation examples',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSecondaryContainer.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Declarative Animations',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          
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

/// Navigation Example Page
class NavigationExamplePage extends StatelessWidget {
  const NavigationExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Animations'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'All Navigation Types',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Test all navigation methods with platform-specific animations',
            style: TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          
          // Section: Push Navigation
          _buildSectionTitle('1. Push Navigation'),
          const SizedBox(height: 12),
          
          // iOS Push
          _buildNavigationCard(
            context: context,
            title: 'Push (iOS Style)',
            description: 'Slide from right, 500ms, easeInOut',
            icon: Icons.phone_iphone,
            color: Colors.blue,
            onTap: () {
              swift.push(const DetailPage(title: 'Push - iOS Style'))
                .ios()
                .duration(500)
                .curve(Curves.easeInOut)
                .go(context);
            },
          ),
          
          const SizedBox(height: 12),
          
          // Android Push
          _buildNavigationCard(
            context: context,
            title: 'Push (Android Style)',
            description: 'Fade + slide up, 500ms, easeInOut',
            icon: Icons.android,
            color: Colors.green,
            onTap: () {
              swift.push(const DetailPage(title: 'Push - Android Style'))
                .android()
                .duration(500)
                .curve(Curves.easeInOut)
                .go(context);
            },
          ),
          
          const SizedBox(height: 12),
          
          // Web Push
          _buildNavigationCard(
            context: context,
            title: 'Push (Web Style)',
            description: 'Fade transition, 400ms, easeOut',
            icon: Icons.web,
            color: Colors.purple,
            onTap: () {
              swift.push(const DetailPage(title: 'Push - Web Style'))
                .web()
                .duration(400)
                .curve(Curves.easeOut)
                .go(context);
            },
          ),
          
          const SizedBox(height: 24),
          
          // Section: Push Replacement
          _buildSectionTitle('2. Push Replacement'),
          const SizedBox(height: 12),
          
          // iOS Push Replacement
          _buildNavigationCard(
            context: context,
            title: 'Push Replacement (iOS)',
            description: 'Replace current route, 300ms',
            icon: Icons.swap_horiz,
            color: Colors.orange,
            onTap: () {
              swift.pushReplacement(const DetailPage(title: 'Push Replacement - iOS'))
                .ios()
                .duration(300)
                .curve(Curves.easeInOut)
                .go(context);
            },
          ),
          
          const SizedBox(height: 12),
          
          // Android Push Replacement
          _buildNavigationCard(
            context: context,
            title: 'Push Replacement (Android)',
            description: 'Replace current route, 400ms',
            icon: Icons.swap_horiz,
            color: Colors.teal,
            onTap: () {
              swift.pushReplacement(const DetailPage(title: 'Push Replacement - Android'))
                .android()
                .duration(400)
                .curve(Curves.easeInOut)
                .go(context);
            },
          ),
          
          const SizedBox(height: 24),
          
          // Section: Push Route
          _buildSectionTitle('3. Push Route'),
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Push Route (iOS)',
            description: 'Push route object, 500ms',
            icon: Icons.route,
            color: Colors.indigo,
            onTap: () {
              swift.pushRoute(const DetailPage(title: 'Push Route - iOS'))
                .ios()
                .duration(500)
                .curve(Curves.easeInOut)
                .go(context);
            },
          ),
          
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Push Route (Android)',
            description: 'Push route object, 500ms',
            icon: Icons.route,
            color: Colors.cyan,
            onTap: () {
              swift.pushRoute(const DetailPage(title: 'Push Route - Android'))
                .android()
                .duration(500)
                .curve(Curves.easeInOut)
                .go(context);
            },
          ),
          
          const SizedBox(height: 24),
          
          // Section: Push Named
          _buildSectionTitle('4. Push Named'),
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Push Named (iOS)',
            description: 'Push named route, 500ms',
            icon: Icons.label,
            color: Colors.pink,
            onTap: () {
              swift.pushNamed('/detail')
                .ios()
                .duration(500)
                .curve(Curves.easeInOut)
                .go(context, arguments: {'from': 'navigation_example'});
            },
          ),
          
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Push Named (Android)',
            description: 'Push named route, 500ms',
            icon: Icons.label,
            color: Colors.deepOrange,
            onTap: () {
              swift.pushNamed('/detail')
                .android()
                .duration(500)
                .curve(Curves.easeInOut)
                .go(context, arguments: {'from': 'navigation_example'});
            },
          ),
          
          const SizedBox(height: 24),
          
          // Section: Push Replacement Named
          _buildSectionTitle('5. Push Replacement Named'),
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Push Replacement Named (iOS)',
            description: 'Replace with named route, 300ms',
            icon: Icons.swap_calls,
            color: Colors.amber,
            onTap: () {
              swift.pushReplacementNamed('/login')
                .ios()
                .duration(300)
                .curve(Curves.easeInOut)
                .go(context, result: 'replaced');
            },
          ),
          
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Push Replacement Named (Android)',
            description: 'Replace with named route, 400ms',
            icon: Icons.swap_calls,
            color: Colors.lime,
            onTap: () {
              swift.pushReplacementNamed('/login')
                .android()
                .duration(400)
                .curve(Curves.easeInOut)
                .go(context, result: 'replaced');
            },
          ),
          
          const SizedBox(height: 24),
          
          // Section: Push Named And Remove Until
          _buildSectionTitle('6. Push Named And Remove Until'),
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Push Named & Remove Until (iOS)',
            description: 'Clear stack until home, 500ms',
            icon: Icons.clear_all,
            color: Colors.red,
            onTap: () {
              swift.pushNamedAndRemoveUntil('/home')
                .ios()
                .duration(500)
                .curve(Curves.easeInOut)
                .go(context, predicate: (route) => false);
            },
          ),
          
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Push Named & Remove Until (Android)',
            description: 'Clear stack until home, 500ms',
            icon: Icons.clear_all,
            color: Colors.brown,
            onTap: () {
              swift.pushNamedAndRemoveUntil('/home')
                .android()
                .duration(500)
                .curve(Curves.easeInOut)
                .go(context, predicate: (route) => false);
            },
          ),
          
          const SizedBox(height: 24),
          
          // Section: Push And Remove Until
          _buildSectionTitle('7. Push And Remove Until'),
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Push & Remove Until (iOS)',
            description: 'Clear stack, push new route, 500ms',
            icon: Icons.delete_sweep,
            color: Colors.deepPurple,
            onTap: () {
              swift.pushAndRemoveUntil(const DetailPage(title: 'Push & Remove Until - iOS'))
                .ios()
                .duration(500)
                .curve(Curves.easeInOut)
                .go(context, predicate: (route) => false);
            },
          ),
          
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Push & Remove Until (Android)',
            description: 'Clear stack, push new route, 500ms',
            icon: Icons.delete_sweep,
            color: Colors.blueGrey,
            onTap: () {
              swift.pushAndRemoveUntil(const DetailPage(title: 'Push & Remove Until - Android'))
                .android()
                .duration(500)
                .curve(Curves.easeInOut)
                .go(context, predicate: (route) => false);
            },
          ),
          
          const SizedBox(height: 24),
          
          // Section: Different Curves
          _buildSectionTitle('8. Different Animation Curves'),
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Ease Out Curve',
            description: 'iOS style, easeOut curve',
            icon: Icons.trending_down,
            color: Colors.blueAccent,
            onTap: () {
              swift.push(const DetailPage(title: 'Ease Out Curve'))
                .ios()
                .duration(500)
                .curve(Curves.easeOut)
                .go(context);
            },
          ),
          
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Ease In Curve',
            description: 'Android style, easeIn curve',
            icon: Icons.trending_up,
            color: Colors.greenAccent,
            onTap: () {
              swift.push(const DetailPage(title: 'Ease In Curve'))
                .android()
                .duration(500)
                .curve(Curves.easeIn)
                .go(context);
            },
          ),
          
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Bounce Out Curve',
            description: 'iOS style, bounceOut curve',
            icon: Icons.sports_volleyball,
            color: Colors.orangeAccent,
            onTap: () {
              swift.push(const DetailPage(title: 'Bounce Out Curve'))
                .ios()
                .duration(600)
                .curve(Curves.bounceOut)
                .go(context);
            },
          ),
          
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Elastic Out Curve',
            description: 'Android style, elasticOut curve',
            icon: Icons.auto_awesome,
            color: Colors.purpleAccent,
            onTap: () {
              swift.push(const DetailPage(title: 'Elastic Out Curve'))
                .android()
                .duration(800)
                .curve(Curves.elasticOut)
                .go(context);
            },
          ),
          
          const SizedBox(height: 24),
          
          // Section: Different Durations
          _buildSectionTitle('9. Different Durations'),
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Fast Animation (200ms)',
            description: 'Quick transition',
            icon: Icons.speed,
            color: Colors.yellow,
            onTap: () {
              swift.push(const DetailPage(title: 'Fast Animation (200ms)'))
                .ios()
                .duration(200)
                .curve(Curves.easeInOut)
                .go(context);
            },
          ),
          
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Normal Animation (500ms)',
            description: 'Standard transition',
            icon: Icons.timer,
            color: Colors.blue,
            onTap: () {
              swift.push(const DetailPage(title: 'Normal Animation (500ms)'))
                .ios()
                .duration(500)
                .curve(Curves.easeInOut)
                .go(context);
            },
          ),
          
          const SizedBox(height: 12),
          
          _buildNavigationCard(
            context: context,
            title: 'Slow Animation (1000ms)',
            description: 'Slow transition',
            icon: Icons.hourglass_empty,
            color: Colors.red,
            onTap: () {
              swift.push(const DetailPage(title: 'Slow Animation (1000ms)'))
                .android()
                .duration(1000)
                .curve(Curves.easeInOut)
                .go(context);
            },
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
  
  Widget _buildNavigationCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      color: color,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 32, color: Colors.white),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

/// Detail Page for Navigation Examples
class DetailPage extends StatelessWidget {
  final String title;
  
  const DetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Navigation animation completed!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// Buy Me a Coffee Card Widget
class _BuyMeACoffeeCard extends StatelessWidget {
  const _BuyMeACoffeeCard();

  Future<void> _openBuyMeACoffee() async {
    final uri = Uri.parse('https://buymeacoffee.com/ravikinha');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFDD00), // Buy Me a Coffee yellow
              const Color(0xFFFFC107),
            ],
          ),
        ),
        child: InkWell(
          onTap: _openBuyMeACoffee,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.coffee,
                    color: Colors.brown,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '☕ Support the Project',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Help create more plugins & features!',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Support',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.brown,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Colors.brown,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
