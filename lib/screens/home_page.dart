import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:anmaya/widgets/bottom_navbar.dart';
import 'package:anmaya/widgets/sidebar.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Deep links are configured via settings if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Home'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const Sidebar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/signin'),
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push('/signup'),
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push('/programs'),
              child: const Text('Courses'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/server-check'),
              child: const Text('Check Server Connection'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
