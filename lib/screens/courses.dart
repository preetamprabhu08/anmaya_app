import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Courses')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Courses Page'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/server-check');
              },
              child: const Text('Check Server Connection'),
            ),
          ],
        ),
      ),
    );
  }
}
