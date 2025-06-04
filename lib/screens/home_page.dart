// lib/screens/home_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anmaya/app_colors.dart'; // your custom colors
import 'package:anmaya/widgets/static/bottom_navbar.dart';
import 'package:anmaya/widgets/static/sidebar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch screen width to adjust layouts if needed
    final screenWidth = MediaQuery.of(context).size.width;

    // For mobile, we'll show 2 columns in the feature grid; 
    // you can bump this up to 3 on tablets by checking screenWidth.
    final featureCrossAxisCount = screenWidth < 600 ? 2 : 3;

    return Scaffold(
      backgroundColor: AppColors.black1,
      // AppBar with hamburger menu to open sidebar
      appBar: AppBar(
        title: const Text('Anmaya'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const Sidebar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ─────────────────────────────────────
            // Hero Section
            // ─────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'We are on mission\n'
                    'to empower\n'
                    'Semiconductor Echo System',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.text1,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Discover a world of knowledge with our cutting-edge\n'
                    'Learning Management System',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.text2,
                          fontSize: 18,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: SizedBox(
                      width: 220,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).push('/signup');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent1,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 6,
                          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        child: const Text('Get Started'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Hero Image with gradient overlay and animation
                  Center(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.95, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      builder: (context, scale, child) => Transform.scale(
                        scale: scale,
                        child: child,
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              'https://anmaya.in/assets/landingPageHeader-zWhH1-Kz.webp',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.25),
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.15),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            Divider(
              color: Colors.white.withOpacity(0.08),
              thickness: 1.5,
              indent: 40,
              endIndent: 40,
            ),
            const SizedBox(height: 32),

            // ─────────────────────────────────────
            // Features Section Heading
            // ─────────────────────────────────────
            Center(
              child: Text(
                'Features that Elevate Your Learning',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primary3,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      letterSpacing: 1.1,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // ─────────────────────────────────────
            // Features Grid
            // ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.9,
                ),
                children: [
                  _FeatureCard(
                    title: 'Interactive Courses',
                    subtitle: 'Engage with dynamic,\nmultimedia-rich content.',
                    imageUrl: 'https://elearningindustry.com/wp-content/uploads/2021/07/Create-Interactive-eLearning-Content-In-3-Steps.png',
                  ),
                  _FeatureCard(
                    title: 'Progress Tracking',
                    subtitle: 'Monitor your learning journey\nwith detailed analytics.',
                    imageUrl: 'https://images.www.talentlms.com/blog/wp-content/uploads/2019/10/talentlms-employee-training-tracking.png',
                  ),
                  _FeatureCard(
                    title: 'Collaborative Learning',
                    subtitle: 'Connect and learn with peers\nfrom around the world.',
                    imageUrl: 'https://content.thriveglobal.com/wp-content/uploads/2018/07/Cooperative_Learning_image.jpg?w=1200',
                  ),
                  _FeatureCard(
                    title: 'Mobile Learning',
                    subtitle: 'Access your courses anytime,\nanywhere on any device.',
                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhM0lsENt5pfF2bXojgm1CTJ_0qI3sMZqWVg&s',
                  ),
                  _FeatureCard(
                    title: 'Personalized Path',
                    subtitle: 'Tailored learning experiences\nbased on your goals.',
                    imageUrl: 'https://elearningindustry.com/wp-content/uploads/2022/08/Shutterstock_700543810.jpg',
                  ),
                  _FeatureCard(
                    title: 'Expert Instructors',
                    subtitle: 'Learn from industry professionals\nand thought leaders.',
                    imageUrl: 'https://physicsworld.com/wp-content/uploads/2023/07/Brilliant-club.jpg',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            Divider(
              color: Colors.white.withOpacity(0.08),
              thickness: 1.5,
              indent: 40,
              endIndent: 40,
            ),
            const SizedBox(height: 32),

            // ─────────────────────────────────────
            // Testimonial Section
            // ─────────────────────────────────────
            Center(
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 800),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 500),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.07),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Column(
                    children: [
                      const Icon(Icons.format_quote, color: Colors.white, size: 40),
                      const SizedBox(height: 12),
                      const CircleAvatar(
                        radius: 36,
                        backgroundImage: NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1672691612717-954cdfaaa8c5?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmVzc2lvbmFsJTIwd29tYW58ZW58MHx8MHx8fDA%3D',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '“This LMS has transformed the way I approach online learning. '
                        'The interactive courses and supportive community have made '
                        'my educational journey both enjoyable and effective.”',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.text2,
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '- Sarah Johnson, Data Science Student',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.text3,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
            Divider(
              color: Colors.white.withOpacity(0.08),
              thickness: 1.5,
              indent: 40,
              endIndent: 40,
            ),
            const SizedBox(height: 32),

            // ─────────────────────────────────────
            // Final CTA Section
            // ─────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.accent1.withOpacity(0.18), AppColors.background],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(
                    'Ready to Start Your Learning Adventure?',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Join thousands of learners and unlock your potential today!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: 240,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        GoRouter.of(context).push('/signup');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent1,                        
                        padding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 36,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 8,
                        textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Sign Up Now'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

/// A small reusable widget for each feature card
class _FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const _FeatureCard({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            colors: [
              AppColors.primary6,
              AppColors.primary8,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.10),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Vertical accent bar
            Container(
              width: 8,
              height: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primary3,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  bottomLeft: Radius.circular(28),
                ),
              ),
            ),
            // Image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: 90,
                  height: 120,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.13),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black1,
                            fontSize: 22,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.text4,
                            fontSize: 16,
                          ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
